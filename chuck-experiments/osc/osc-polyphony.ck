//------------------------------------------------
// name: polyfony.ck
// desc: polyfonic mandolin model with OSC control
//
// authors: Ananya Misra, Ge Wang, Paul Winkler
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

class NoteOffEvent extends Event
{
    time started; // So we can track age
    Event finished; // So we can tell when the note has really stopped.
}

// So we can control how many voices active at once (and how many shreds are running).
6 => int number_voices;
// So we can detect when all shreds busy.
0 => int number_active_voices;

// array of events to trigger when receiving note OFF, indexed by pitch.
// Note this assumes something like MIDI pitch; would need another strategy
// for very large or infinite pitch systems.
NoteOffEvent @ note_offs[128];

// Main output bus. JCRev = Chowning style reverb.
Gain output_bus => JCRev reverb => dac;
.1 => output_bus.gain;
.2 => reverb.mix;

// Wrap up your instrument(s) in functions that take on and off events and play ONE note.
fun void play_note_using_clarinet(NoteEvent on_event, NoteOffEvent off_event) {
    // Sustains forever until note-off, then sudden stop.
    Clarinet instrument;

    instrument => output_bus;
    Std.mtof( on_event.note ) => instrument.freq;
    0.2 + on_event.velocity / 128.0 * 0.6 => instrument.startBlowing;

    // Play until we receive our note-off event.
    off_event => now;
    instrument.stopBlowing(10.0);
    instrument =< output_bus;
}

fun void play_note_using_mandolin(NoteEvent on_event, NoteOffEvent off_event) {
    Mandolin instrument;

    instrument => output_bus;
    Std.mtof( on_event.note ) => instrument.freq;
    Math.random2f( .5, .85 ) => instrument.pluckPos;
    on_event.velocity / 128.0 => instrument.pluck;

    // Play until we receive our note-off event.
    off_event => now;
    instrument =< output_bus;
}

fun void play_adsr_synth(NoteEvent on_event, NoteOffEvent off_event) {
    // TODO
}

// Note on is global because the main shred triggers them
NoteEvent on;

// Loop function to handle a single voice.
fun void voice_loop(int shred_number)
{

    NoteOffEvent off;
    int note;

    // Play one note at a time, forever.
    while( true )
    {
        // Set up our events to handle lifecycle of this note.
        on => now;
        on.note => note;
        1 +=> number_active_voices;
        now => off.started;
        off @=> note_offs[note];

        // Randomly choose an instrument and play one note.
        // TODO handle multiple voices better
        if (Math.random2(0, 5) > 4) {
            play_note_using_clarinet(on, off);
        } else {
            play_note_using_mandolin(on, off);
        }

        <<< now, "FREEING", shred_number, note >>>;
        // Remove our note off event IFF it's still the one we registered.
        // Otherwise, assume that array slot was overwritten by another shred!
        if (note_offs[note] == off) {
            null @=> note_offs[note];
        }
        1 -=> number_active_voices;
        off.finished.signal();
        <<< now, "Signaled callback that we're free" >>>;
    }
}

<<< "Initializing", number_voices, "voices by sporking a handler for each" >>>;
for( 0 => int i; i < number_voices; i++ ) spork ~ voice_loop(i);

// infinite time-loop
while( true )
{
    // wait on OSC event
    oin => now;

    // get the OSC message from the message queue
    while( oin.recv( msg ) )
    {
        if ( msg.address == "/note/on" )
        {
            // Assume a message with 2 int args: note number 0-127 and velocity 0-127.
            // NOTE we could also have used OSC message type of `m`
            // which is embedded midi event.
            msg.getInt(0) => on.note;
            msg.getInt(1) => on.velocity;
            <<< now, "Got note with", on.note, "and", on.velocity, ". active:", number_active_voices >>>;

            // First stop any voice currently playing same note, and wait for it.
            if( note_offs[on.note] != null ) {
                <<< now, "Stopping existing note", on.note >>>;
                note_offs[on.note].signal();
                note_offs[on.note].finished => now;
            }
            else if( number_active_voices >= number_voices)
            {
                // Voice stealing! If we have no voices free, free the oldest one,
                // and wait for it.
                now => time oldest_start_time;
                null => NoteOffEvent oldest_note_off;
                for( 0 => int i; i < note_offs.size(); i++ ) {
                    if (note_offs[i] != null && note_offs[i].started < oldest_start_time) {
                        note_offs[i] @=> oldest_note_off;
                        oldest_note_off.started => oldest_start_time;
                    }
                }
                if( oldest_note_off != null ) {
                    <<< now, "Stealing oldest voice which started", oldest_note_off.started >>>;
                    oldest_note_off.signal();
                    <<< now, "Waiting for cleanup" >>>;
                    oldest_note_off.finished => now;
                }
                else {
                    <<< now, "All voices busy and couldn't free one. Bug!" >>>;
                }
            }
            if (number_active_voices < number_voices) {
                // Signal the "on" event
                <<< now, "On signaled!" >>>;
                on.signal();
                // yield without advancing time to allow shred to run
                me.yield();
            }
            else {
                // This can still happen occasionally under heavy load
                <<< now, "Dropped note!!!!", on.note >>>;
            }
        }
        else if( msg.address == "/note/off" )
        {
            <<< "handling note off", msg.getInt(0) >>>;
            if( note_offs[msg.getInt(0)] != null ) note_offs[msg.getInt(0)].signal();
            // TBD: How does this design handle release time after note-off in eg ADSR?
        }
        else
        {
            <<< "Unhandled event at address", msg.address, "type", msg.typetag >>>;
        }
    }
}
