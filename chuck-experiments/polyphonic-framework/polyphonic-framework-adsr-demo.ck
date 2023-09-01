//------------------------------------------------
// name: polyphonic-framework-adsr-demo.ck
// desc: W.I.P. Demo of object-oriented polyphony with handling of ADSR release.
// Author: Paul Winkler
// send all complaints to /dev/null
//--------------------------------------------


// OSC in
OscIn oin;

// Listen on port for UDP
6449 => oin.port;

// Optional first arg is how much polyphony to support
int polyphony;
if( me.args() ) {
    me.arg(0) => Std.atoi => polyphony;
}
else {
    4 => polyphony;
}
<<< "Set polyphony to", polyphony >>>;

cherr <= "listening for OSC messages over port: " <= oin.port()
      <= "..." <= IO.newline();
oin.listenAll();

// something to shuttle data
OscMsg msg;

// Main output bus. JCRev = Chowning style reverb.
Gain output_bus => JCRev reverb => dac;
.1 => output_bus.gain;
0 => reverb.mix;

// Assume we have loaded polyphonic-framework.ck before now.


//////////////////////////////////////////////////////////////////////
// More complicated instrument with ADSR
class PolyphonicAdsrSynth extends PolyphonicInstrumentBase {

    fun void play_one_note(NoteParams params, NoteOffEvent off_event) {

        <<< now, "\n\nplay_one_note called with", params.note, " in", me >>>;
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

        5::ms => attack;
        50::ms => decay;
        0.6 => sustain;
        4000::ms => release;

        adsr.set( attack, decay, sustain, release);

        adsr.keyOn();
        // <<< now, "keyed on waiting for off in", me>>>;
        // Wait for off signal
        off_event => now;
        // <<< now, "got off event", off_event, "in", me>>>;

        // Handle release.
        // Can this complexity move into the framework?
        if ( off_event.steal == 1 ) {
            <<< now, "ADSR stolen", params.note >>>;
            2::ms => release;
            adsr.set( attack, decay, sustain, release);
            adsr.keyOff();
            release => now;
            adsr =< output;
            // <<< now, "Disconnected after quick steal in", me>>>;
            off_event.finished.signal();
        } else {
            // Experimental attempt at handling natural release from note-off events
            // AND allowing stealing DURING release.
            adsr.keyOff();
            <<< now, "ADSR release started for", params.note >>>;
            // Set up a NEW event so we can steal a voice during a long decay.
            // Note we aren't doing even a short decay here, so it may be abrupt
            NoteOffEvent finish_release;
            off_event.started => finish_release.started;
            off_event.finished @=> finish_release.finished;
            0 => finish_release.steal;
            // <<< now, "replacing off event", off_event, " with", finish_release, " in", me >>>;
            finish_release @=> note_offs[params.note];
            spork ~ interruptible_release(release, finish_release, adsr, params.note);
            // <<< now, "Sporked interruptible_release, returning without waiting or cleaning up in", me>>>;
        }
    }

    fun void interruptible_release(dur duration, NoteOffEvent interrupt, UGen adsr, int note) {
        now + duration => time deadline;
        // <<< now, "SLEEPING until max deadline", deadline, "for NoteOffEvent", interrupt, " in", me>>>;
        while ( now < deadline) {
            // This is a bit of a weird hack: we're re-using an event instance as a data object
            // but we're not waiting for it to be signaled, instead we're polling for a data change.
            // This is a workaround for ChucK limitation: there's no way to express
            // "I want to wait for either of a signal OR a time, whichever is first."
            if (interrupt.steal > 0) {
                <<< now, "Interrupting RELEASE with a steal in", me >>>;
                break;
            }
            5::ms => now;
        }
        if ( now >= deadline ) {
            // <<< now, "RELEASE DONE via timeout in", me>>>;
        }
        adsr =< output;
        // Clean up our event if it's still there
        if ( note_offs[note] == interrupt ) {
            null @=> note_offs[note];
        }
        interrupt.finished.signal();
    }
}



PolyphonicAdsrSynth synth;
synth.output => output_bus;
synth.setup_voice_shreds(polyphony);


// Main loop is easy:
// Just make calls to play() and stop() at the right times.
// No need to worry how it works or manage events.
//
// This example triggers notes when receiving simple OSC messages.
// It would be easy to adapt to MIDI or manually scheduled notes, etc.
while( true )
{
    // Wait on OSC event.
    // Interesting: This is the only time advance in the main shred!
    oin => now;

    // get the OSC message from the message queue.
    while( oin.recv( msg ) )
    {
        if ( msg.address.find("/note/on") == 0 )
        {
            // <<< now, "~~~~~~~~~~~~~~~~~~~~~~~~~~~ Starting note-on in main shred", me >>>;

            // Assume a message with 2 int args: note number 0-127 and velocity 0-127.
            // NOTE we could also have used OSC message type of `m`
            // which is embedded midi event.

            NoteParams params;
            msg.getInt(0) => params.note;
            msg.getInt(1) => params.velocity;

            <<< now, "Starting play in main loop", me>>>;
            synth.play(params);
        }
        else if( msg.address.find("/note/off") == 0 )
        {
            msg.getInt(0) => int note;
            <<< now, "   got note off event, calling stop", note, "in main loop", me>>>;
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
