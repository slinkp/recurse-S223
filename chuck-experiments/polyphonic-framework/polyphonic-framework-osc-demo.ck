//------------------------------------------------
// name: polyphonic-framework-osc-demo.ck
// desc: Object-oriented polyphony with voice stealing via OSC
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
// Simple example polyphonic instrument

class PolyMando extends PolyphonicInstrumentBase {

    fun void play_one_note(NoteParams params, NoteOffEvent off_event) {
        Mandolin instrument;

        instrument => output; // output is provided by superclass, please use it.
        Std.mtof( params.note ) => instrument.freq;
        Math.random2f( .5, .85 ) => instrument.pluckPos;
        params.velocity / 128.0 => instrument.pluck;

        off_event => now;
        instrument =< output;
    }
}

// Here's how to use it!
// Step 1: Make one instance.
PolyMando mando;
// Step 2. Connect output so we can hear it.
mando.output => output_bus;
// Step 3. Say how much polyphony you want.
mando.setup_voice_shreds(polyphony);
// To make notes, just call mando.play(params) and mando.stop(note) at the desired times,
// see the main loop at bottom for examples.
// These are fire-and-forget, you can yield or manage time however you like between calls.


//////////////////////////////////////////////////////////////////////
// More complicated instrument with ADSR
class PolyphonicAdsrSynth extends PolyphonicInstrumentBase {

    fun void play_one_note(NoteParams params, NoteOffEvent off_event) {

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
        // Math.random2(1000, 2000)::ms => release;
        1000::ms => release;

        adsr.set( attack, decay, sustain, release);

        adsr.keyOn();

        // Wait for off signal
        off_event => now;

        // Handle release.
        if ( off_event.steal == 1 ) {
            <<< now, "ADSR interrupted", params.note >>>;
            2::ms => release;
            adsr.set( attack, decay, sustain, release);
            adsr.keyOff();
            release => now;
        } else {
            // Natural release. This breaks timing when stealing voices :(
            // because we don't have a way to interrupt the release time
            // so once the release starts, the voice is not stealable.
            adsr.keyOff();
            <<< now, "ADSR release started for", params.note >>>;
            release => now;
        }
        <<< now, "ADSR finished", params.note, "in", me >>>;
        adsr =< output;
    }
}



// Now wire that up just like other example instrument.
PolyphonicAdsrSynth synth;
synth.output => output_bus;
synth.setup_voice_shreds(polyphony);


// Route to each instrument depending on OSC message
fun PolyphonicInstrumentBase get_instrument_from_message(OscMsg msg) {
    if (msg.address.find("mando") > -1) {
        return mando;
    } else {
        return synth;
    }
}

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
            // Assume a message with 2 int args: note number 0-127 and velocity 0-127.
            // NOTE we could also have used OSC message type of `m`
            // which is embedded midi event.

            NoteParams params;
            msg.getInt(0) => params.note;
            msg.getInt(1) => params.velocity;
            <<< "Starting note-on...", params.note >>>;

            // Find the instrument to handle this note, and play it.
            get_instrument_from_message(msg) @=> PolyphonicInstrumentBase instrument;
            instrument.play(params);
        }
        else if( msg.address.find("/note/off") == 0 )
        {
            get_instrument_from_message(msg) @=> PolyphonicInstrumentBase instrument;
            msg.getInt(0) => int note;
            <<< "handling note off", note >>>;
            instrument.stop(note);
        }
        else
        {
            <<< "Unhandled event at address", msg.address, "type", msg.typetag >>>;
        }
        // yield without advancing time to allow shred to run
        me.yield();
    }
}

