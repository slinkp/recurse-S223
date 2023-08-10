//------------------------------------------------
// name: osc-polyphony-objects.ck
// desc: Object-oriented polyphony with voice stealing via OSC
// Author: Paul Winkler
// Inspired by polyfony.ck by Ananya Misra, Ge Wang
// send all complaints to /dev/null
//--------------------------------------------


// OSC in
OscIn oin;

// Optional first arg is UDP port for OSC messages.
if( me.args() ) me.arg(0) => Std.atoi => oin.port;
else 6449 => oin.port;

cherr <= "listening for OSC messages over port: " <= oin.port()
      <= "..." <= IO.newline();
oin.listenAll();

// something to shuttle data
OscMsg msg;

// make our own events
class NoteEvent extends Event
{
    int note; // Assume MIDI range 0-127; 69 == middle C
    int velocity; // Assume MIDI range 0-127
}

// This is currently ONE global "on" event. That means do NOT update it in child shreds or things get weird.
NoteEvent on;

class NoteOffEvent extends Event
{
    time started; // So we can track age
    Event finished; // So we can tell when the note has really stopped.
    int steal; // 0 = allow to decay, 1 = steal
}

// Subclass this to get polyphony!
// Just override `play_one_note`.
class PolyphonicInstrumentBase {
    // Subclass this!

    // So we can control how many voices active at once (and how many shreds are running).
    4 @=> int number_voices;
    // So we can detect when all shreds busy.
    0 @=> int number_active_voices;

    // NoteEvent on; // Scoped to this instrument.

    Gain output => blackhole;

    // array of events to trigger when receiving note OFF, indexed by pitch.
    // Note this assumes something like MIDI pitch; would need another strategy
    // for very large or infinite pitch systems.
    NoteOffEvent @ note_offs[128];

    fun void play_one_note(NoteEvent on_event, NoteOffEvent off_event) {
        <<< "TODO override this" >>>;
        off_event => now;  // You probably want this.
    }


    ////////////////////////////////////////////////////////////////////////////////////////////
    // You shouldn't need to override anything below this.
    ////////////////////////////////////////////////////////////////////////////////////////////

    fun void setup_voice_shreds(int n) {
        n @=> number_voices;
        for( 0 => int i; i < number_voices; i++ ) {
            <<< "Sporking", i >>>;
            spork ~ voice_loop(i);
        }
    }

    fun void play(NoteEvent on_event) {
        // Call this from your main shred to start a note.
        // Should NOT need to override this.
        // It just starts a note, with voice stealing logic to ensure we never run out of voices.
        //

        // on_event @=> on; // TODO does this scope correctly and child shreds can see it?

        // First stop any voice currently playing same note, and wait for it to stop.
        <<< "Starting play" >>>;
        if( note_offs[on_event.note] != null ) {
            <<< now, "Stopping existing note", on_event.note >>>;
            1 => note_offs[on_event.note].steal;
            note_offs[on_event.note].signal();
            // Wait for note cleanup code to finish; if we start note before that, the voice won't be free.
            note_offs[on_event.note].finished => now;
        }
        else if( number_active_voices >= number_voices) {
            // Voice stealing! If we have no voices free, free the oldest one,
            // and wait for it.
            if (number_active_voices > number_voices) {
                <<< "Bug!", number_active_voices, "active, this should never happen" >>>;
            }
            now => time oldest_start_time;
            null => NoteOffEvent oldest_note_off;
            for( NoteOffEvent maybe_oldest: note_offs ) {
                if (maybe_oldest != null && maybe_oldest.started <= oldest_start_time) {
                    maybe_oldest @=> oldest_note_off;
                    oldest_note_off.started => oldest_start_time;
                }
            }
            if( oldest_note_off != null ) {
                <<< now, "Stealing oldest voice which started", oldest_note_off.started >>>;
                1 => oldest_note_off.steal;
                oldest_note_off.signal();
                // Wait for note cleanup code to finish; if we start note before that, the voice won't be free.
                oldest_note_off.finished => now;
            }
            else {
                // This should never happen :)
                <<< now, "All voices busy and couldn't free one. Bug!" >>>;
            }
        }
        if (number_active_voices < number_voices) {
            // Signal the "on" event -
            // THE ONE WE RECEIVED.
            on_event.signal();
            <<< now, "On signaled!", on_event, me >>>;
        }
        else {
            // This shouldn't happen even under heavy load.
            <<< now, "Dropped note!!!!", on_event.note >>>;
        }
    }

    fun void voice_loop(int shred_number) {  // , NoteEvent on) {
        // Play one note at a time, forever.
        // You shouldn't need to override this.
        NoteOffEvent off;
        int note;

        while( true )
        {
            // Wait for a note start to be signaled.
            <<< "Waiting for a note event in", shred_number, on, me>>>;
            on => now;
            <<< "GOt into the note loop!" >>>;
            on.note => note;
            1 +=> number_active_voices;
            now => off.started;
            off @=> note_offs[note];
            <<< "Registered note-off", off, "for note", note >>>;

            // Start the synth playing. This should wait for `off` internally,
            // and clean itself up (ie disconnect from output).
            play_one_note(on, off);

            // Remove our note off event IFF it's still the one we registered.
            // Otherwise, assume that array slot was overwritten by another shred!
            if (note_offs[note] == off) {
                null @=> note_offs[note];
            }
            1 -=> number_active_voices;
            off.finished.signal();
            <<< now, "Sent finished.signal(), now active:", number_active_voices >>>;
        }
    }
}

// Simple example

class PolyMando extends PolyphonicInstrumentBase {

    fun void play_one_note(NoteEvent on_event, NoteOffEvent off_event) {
        Mandolin instrument;

        instrument => output;
        Std.mtof( on_event.note ) => instrument.freq;
        Math.random2f( .5, .85 ) => instrument.pluckPos;
        on_event.velocity / 128.0 => instrument.pluck;

        off_event => now;
        instrument =< output;
    }
}

// More complicated example handling ADSR
class PolyphonicAdsrSynth extends PolyphonicInstrumentBase {

    fun void play_one_note(NoteEvent on_event, NoteOffEvent off_event) {

        dur attack;
        dur decay;
        float sustain;
        dur release;

        ADSR adsr => output;
        TriOsc osc1 => adsr;
        TriOsc osc2 => adsr;
        TriOsc subosc => adsr;

        Std.mtof( on_event.note ) => float freq;
        freq => osc1.freq;
        freq * 1.0055 => osc2.freq;
        freq * 0.498 => subosc.freq;

        0.5 => osc1.gain;
        0.5 => osc2.gain;
        0.6 => subosc.gain;

        Math.random2(2, 500)::ms => attack;
        Math.random2(2, 50)::ms => decay;
        Math.random2f(0.4, 1.0) => sustain;
        Math.random2(10, 800)::ms => release;

        adsr.set( attack, decay, sustain, release);

        adsr.keyOn();

        // Wait for off signal

        off_event => now;

        <<< now, "ADSR Key off started for", on_event.note >>>;
        // If we are stealing this voice, shorten the release.
        if ( off_event.steal == 1 ) {
            <<< now, "ADSR interrupted", on_event.note >>>;
            2::ms => release;
            adsr.set( attack, decay, sustain, release);
        }
        adsr.keyOff();
        release => now;
        <<< now, "ADSR finished", on_event.note, "in", me >>>;
        adsr =< output;
    }
}

// Main output bus. JCRev = Chowning style reverb.
Gain output_bus => JCRev reverb => dac;
.1 => output_bus.gain;
.2 => reverb.mix;


// Set up each polyphonic instruments. One instance of each handles N voices.
// USAGE: 1. instantiate it..
PolyphonicAdsrSynth synth;
// 2. Wire it up so we can hear it...
synth.output => output_bus;
// 3. Say how much polyphony you want.
synth.setup_voice_shreds(2);

PolyMando mando;
mando.output => output_bus;
mando.setup_voice_shreds(8);


fun PolyphonicInstrumentBase dispatch(OscMsg msg) {
    // This could return a different instrument based on ... something in the message TBD.
    if (Math.random2(0, 5) > 4) { // 4) {
        return synth;
    } else {
        return mando;
    }
}

// Wire it all up to OSC messages!
while( true )
{
    // wait on OSC event
    oin => now;

    // get the OSC message from the message queue
    while( oin.recv( msg ) )
    {
        if ( msg.address == "/note/on" )
        {
            <<< "Starting note-on..." >>>;
            // Find the synth to handle this note, and play it.
            dispatch(msg) @=> PolyphonicInstrumentBase synth;

            // Assume a message with 2 int args: note number 0-127 and velocity 0-127.
            // NOTE we could also have used OSC message type of `m`
            // which is embedded midi event.
            msg.getInt(0) => on.note;
            msg.getInt(1) => on.velocity;
            <<< now, "Got note with", on.note, "and", on.velocity >>>;

            synth.play(on);

            // yield without advancing time to allow shred to run
            me.yield();
        }
        else if( msg.address == "/note/off" )
        {
            <<< "handling note off", msg.getInt(0) >>>;
            // TODO we need to dispatch this to a synth too
            // note_offs[msg.getInt(0)] @=> NoteOffEvent off;
            // if( off != null ) {
            //     0 => off.steal; // Allow to decay.
            //     off.signal();
            //     off.finished => now;
            // }
        }
        else
        {
            <<< "Unhandled event at address", msg.address, "type", msg.typetag >>>;
        }
    }
}

