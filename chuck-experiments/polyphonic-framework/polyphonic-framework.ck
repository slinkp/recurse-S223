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

// An object to encapsulate note data makes it easier to change the data format
class NoteParams {
    int note;  // Assume MIDI range 0-127; 69 == middle C
    int velocity; // Assume MIDI range 0-127
}

// make our own events
class NoteEvent extends Event
{
    NoteParams params;
}

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

    NoteEvent on; // Scoped to this instrument.

    Gain output => blackhole;

    // array of events to trigger when receiving note OFF, indexed by pitch.
    // Note this assumes something like MIDI pitch; would need another strategy
    // for very large or infinite pitch systems.
    NoteOffEvent @ note_offs[128];

    fun void play_one_note(NoteParams params, NoteOffEvent off_event) {
        <<< "Playing a note! You should override this" >>>;
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

    fun void stop(int note) {
        // Call from main shred to stop a note.
        // Should NOT need to override this.
        note_offs[note] @=> NoteOffEvent off;
        if( off != null ) {
            0 => off.steal; // Allow to release naturally.
            off.signal();
            // Wait for it to let us know it's done.
            off.finished => now;
            <<< "------------------------\n" >>>;
        }
    }

    fun void play(NoteParams params) {
        // Call this from your main shred to start a note.
        // Should NOT need to override this.
        // It just starts a note, with voice stealing logic to ensure we never run out of voices.
        //

        <<< "Starting play" >>>;

        // First steal any voice currently playing same note.
        note_offs[params.note] @=> NoteOffEvent note_off_to_steal;
        if( note_off_to_steal != null ) {
            <<< now, "Stopping existing note", params.note >>>;
        }
        else if (number_active_voices >= number_voices) {
            // Voice stealing! If we have no voices free, free the oldest one,
            // and wait for it.
            if (number_active_voices > number_voices) {
                <<< "Bug!", number_active_voices, "active, this should never happen" >>>;
            }
            now => time oldest_start_time;
            for( NoteOffEvent maybe_oldest: note_offs ) {
                if (maybe_oldest != null && maybe_oldest.started <= oldest_start_time) {
                    maybe_oldest @=> note_off_to_steal;
                    note_off_to_steal.started => oldest_start_time;
                }
            }
            if (note_off_to_steal == null) {
                // This should never happen :)
                <<< now, "All voices busy and couldn't free one. Bug!" >>>;
            }
            else {
                <<< now, "Stealing oldest voice which started", note_off_to_steal.started >>>;
            }
        }
        if( note_off_to_steal != null ) {
            1 => note_off_to_steal.steal;
            note_off_to_steal.signal();
            // Wait for note cleanup code to finish; if we start note before that, the voice won't be free.
            note_off_to_steal.finished => now;
        }
        if (number_active_voices < number_voices) {
            // Signal the "on" event for THIS synth.
            params @=> on.params;
            on.signal();
            <<< now, "On signaled!", on, me >>>;
        }
        else {
            // This shouldn't happen even under heavy load.
            <<< now, "Dropped note!!!!", params.note >>>;
        }
    }

    fun void voice_loop(int shred_number) {  // , NoteEvent on) {
        // Play one note at a time, forever.
        // You shouldn't need to override this.
        NoteOffEvent off;
        int note;
        NoteParams params;

        while( true )
        {
            // Wait for a note start for this instrument to be signaled.
            on => now;
            1 +=> number_active_voices;
            on.params @=> params;
            params.note => note;
            <<< "Got note event", on, "in", shred_number, me, "with", note >>>;
            now => off.started;
            off @=> note_offs[note];
            <<< "Registered note-off", off, "for note", note >>>;

            // Start the synth playing. This should wait for `off` internally,
            // and clean itself up (ie disconnect from output).
            play_one_note(params, off);

            // BUG: if it takes a while for the note to release,
            // that voice can't be stolen until it finishes naturally.
            // How to interrupt that and signal off.finished() early??

            // Cleanup
            //
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

    fun void play_one_note(NoteParams params, NoteOffEvent off_event) {
        Mandolin instrument;

        instrument => output;
        Std.mtof( params.note ) => instrument.freq;
        Math.random2f( .5, .85 ) => instrument.pluckPos;
        params.velocity / 128.0 => instrument.pluck;

        off_event => now;
        instrument =< output;
    }
}

// More complicated example handling ADSR
class PolyphonicAdsrSynth extends PolyphonicInstrumentBase {

    fun void play_one_note(NoteParams params, NoteOffEvent off_event) {

        <<< "\n\nBANG" >>>;
        dur attack;
        dur decay;
        float sustain;
        dur release;

        ADSR adsr => output;
        TriOsc osc1 => adsr;
        TriOsc osc2 => adsr;
        TriOsc subosc => adsr;

        Std.mtof( params.note ) => float freq;
        freq => osc1.freq;
        freq * 1.0055 => osc2.freq;
        freq * 0.498 => subosc.freq;

        0.5 => osc1.gain;
        0.5 => osc2.gain;
        0.6 => subosc.gain;

        Math.random2(2, 500)::ms => attack;
        Math.random2(2, 50)::ms => decay;
        Math.random2f(0.4, 1.0) => sustain;
        Math.random2(10, 2000)::ms => release;

        adsr.set( attack, decay, sustain, release);

        adsr.keyOn();

        // Wait for off signal

        off_event => now;

        <<< now, "ADSR Key off started for", params.note >>>;
        // If we are stealing this voice, shorten the release.
        if ( off_event.steal == 1 ) {
            <<< now, "ADSR interrupted", params.note >>>;
            2::ms => release;
            adsr.set( attack, decay, sustain, release);
        }
        adsr.keyOff();
        release => now;
        <<< now, "ADSR finished", params.note, "in", me >>>;
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
synth.setup_voice_shreds(1);

PolyMando mando;
mando.output => output_bus;
mando.setup_voice_shreds(8);


fun PolyphonicInstrumentBase dispatch(OscMsg msg) {
    if (msg.address.find("mando") > -1) {
        <<< "Got mandoliln for", msg.address >>>;
        return mando;
    } else {
        <<< "Got adsr synth for", msg.address >>>;
        return synth;
    }
}

// Wire it all up to OSC messages!
while( true )
{
    // wait on OSC event.
    // Interesting: This is the only time advance in the main shred!
    oin => now;

    // get the OSC message from the message queue
    while( oin.recv( msg ) )
    {
        if ( msg.address.find("/note/on") == 0 )
        {
            <<< "Starting note-on..." >>>;

            // Assume a message with 2 int args: note number 0-127 and velocity 0-127.
            // NOTE we could also have used OSC message type of `m`
            // which is embedded midi event.

            NoteParams params;
            msg.getInt(0) => params.note;
            msg.getInt(1) => params.velocity;

            // Find the synth to handle this note, and play it.
            dispatch(msg) @=> PolyphonicInstrumentBase synth;

            <<< now, "Got note with", params.note, "and", params.velocity >>>;
            synth.play(params);

        }
        else if( msg.address.find("/note/off") == 0 )
        {
            msg.getInt(0) => int note;
            <<< "handling note off", note >>>;
            dispatch(msg) @=> PolyphonicInstrumentBase synth;
            synth.stop(note);
        }
        else
        {
            <<< "Unhandled event at address", msg.address, "type", msg.typetag >>>;
        }
        // yield without advancing time to allow shred to run
        me.yield();
    }
}

