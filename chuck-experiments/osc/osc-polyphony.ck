//------------------------------------------------
// name: polyfony.ck
// desc: polyfonic mandolin model with OSC control
//
// authors: Ananya Misra, Ge Wang, Paul Winkler
// send all complaints to /dev/null
//--------------------------------------------


// OSC in
OscIn oin;

// see if port is supplied on command line
if( me.args() ) me.arg(0) => Std.atoi => oin.port;
// default port
else 6449 => oin.port;

// print
cherr <= "listening for OSC messages over port: " <= oin.port()
      <= "..." <= IO.newline();
// listen to everything coming
oin.listenAll();

// something to shuttle data
OscMsg msg;

// make our own event
class NoteEvent extends Event
{
    int note; // Assume MIDI range 0-127; 69 == middle C
    int velocity; // Assume MIDI range 0-127
}

class NoteOffEvent extends Event
{
    time started; // So we can track age
    Event callbackEvent; // So we can tell when the note has really stopped.
}

// So we can control how many voices active at once (and how many shreds are running).
20 => int numberVoices;
// So we can detect when all shreds busy.
0 => int numberActiveVoices;

// the event
NoteEvent on;

// array of ugen's handling each note OFF, indexed by pitch
NoteOffEvent @ note_offs[128];

// the base patch. JCRev = Chowning style reverb
Gain g => JCRev r => dac;
.1 => g.gain;
.2 => r.mix;

// handler for a single voice
fun void handler(int shredNumber)
{
    // don't connect to dac until we need it
    Mandolin m;
    NoteOffEvent off;
    int note;

    while( true )
    {
        on => now;
        now => off.started;
        on.note => note;
        1 +=> numberActiveVoices;
        off @=> note_offs[note];

        // dynamically repatch
        m => g;
        Std.mtof( note ) => m.freq;
        Math.random2f( .6, .8 ) => m.pluckPos;
        on.velocity / 128.0 => m.pluck;

        // Wait for note-off event
        off => now;
        <<< now, "FREE", shredNumber, note >>>;
        // Remove our signal handler IFF it's still the one registered for this note.
        // Otherwise, the array slot may already have been overwritten!
        if (note_offs[note] == off) {
            null @=> note_offs[note];
        }
        m =< g;
        1 -=> numberActiveVoices;
        off.callbackEvent.signal();
        <<< now, "Signaled callback that we're free" >>>;
    }
}

<<< "Initializing", numberVoices, "voices by sporking a handler for each" >>>;
for( 0 => int i; i < numberVoices; i++ ) spork ~ handler(i);

// infinite time-loop
while( true )
{
    // wait on OSC event
    oin => now;

    // get the OSC message from the message queue
    while( oin.recv( msg ) )
    {
        // catch only noteon
        if ( msg.address == "/note/on" )
        {
            // Assume a message with 2 int args: note number 0-127 and velocity 0-127.
            // store midi note number
            // NOTE we could also have used OSC message type of `m` which is embedded midi event
            msg.getInt(0) => on.note;
            // store velocity
            msg.getInt(1) => on.velocity;
            <<< now, "Got note with", on.note, "and", on.velocity >>>;

            // First stop any handler currently playing same note, and wait for it.
            if( note_offs[on.note] != null ) {
                <<< now, "Stopping existing note", on.note >>>;
                note_offs[on.note].signal();
                note_offs[on.note].callbackEvent => now;
            }
            else if( numberActiveVoices >= numberVoices)
            {
                // Voice stealing! If we have no voices free, free the oldest one, and wait for it.
                now => time oldestStartTime;
                null => NoteOffEvent oldestNoteOff;
                for( 0 => int i; i < note_offs.size(); i++ ) {
                    if (note_offs[i] != null && note_offs[i].started < oldestStartTime) {
                        note_offs[i] @=> oldestNoteOff;
                        oldestNoteOff.started => oldestStartTime;
                    }
                }
                if( oldestNoteOff != null ) {
                    <<< now, "Stealing oldest voice which started", oldestNoteOff.started >>>;
                    oldestNoteOff.signal();
                    <<< now, "Waiting for cleanup" >>>;
                    oldestNoteOff.callbackEvent => now;
                }
                else {
                    <<< now, "All voices busy and couldn't free one. Bug!" >>>;
                }
            }
            // Signal the "on" event
            <<< now, "On signaled!" >>>;
            on.signal();
            // yield without advancing time to allow shred to run
            me.yield();
        }
        else if( msg.address == "/note/off" )
        {
            <<< "handling note off", msg.getInt(0) >>>;
            if( note_offs[msg.getInt(0)] != null ) note_offs[msg.getInt(0)].signal();
            // Note we do NOT wait for off.callbackEvent here.
        }
        else
        {
            <<< "Unhandled event at address", msg.address, "type", msg.typetag >>>;
        }
    }
}
