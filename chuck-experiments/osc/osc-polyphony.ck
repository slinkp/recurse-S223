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

// the event
NoteEvent on;
// array of ugen's handling each note OFF
Event @ note_offs[128];

// the base patch. JCRev = Chowning style reverb
Gain g => JCRev r => dac;
.1 => g.gain;
.2 => r.mix;

// handler for a single voice
fun void handler(int shredNumber)
{
    // don't connect to dac until we need it
    Mandolin m;
    Event off;
    int note;

    while( true )
    {
        on => now;
        on.note => note;

        // Check if a voice is already playing this note and stop it if so.
        if( note_offs[note] != null ) {
            <<< now, "CLAIM & stop", shredNumber, "Note", note >>>;
            note_offs[note].signal();
        } else {
            <<< now, "CLAIM init", shredNumber, "Note", note >>>;
        }
        off @=> note_offs[note];

        // dynamically repatch
        m => g;
        Std.mtof( note ) => m.freq;
        Math.random2f( .6, .8 ) => m.pluckPos;
        on.velocity / 128.0 => m.pluck;

        // Wait for note-off event
        off => now;
        // Remove our signal handler IFF it's still the one registered for this note.
        if (note_offs[note] == off) {
            // Do NOT signal any other event that's there because it's likely
            // the one that replaced us!
            null @=> note_offs[note];
        }
        <<< now, "FREE", shredNumber, note >>>;
        m =< g;
    }
}

// spork handlers, one for each voice
for( 0 => int i; i < 20; i++ ) spork ~ handler(i);

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
            // <<< "Got note with", on.note, "and", on.velocity >>>;
            // First stop any handler currently playing same note
            if( note_offs[on.note] != null ) {
                <<< now, "Stopping existing note", on.note >>>;
                note_offs[on.note].signal();
            }
            // Signal the "on" event
            on.signal();
            // yield without advancing time to allow shred to run
            me.yield();
        }
        else if( msg.address == "/note/off" )
        {
            <<< "handling note off", msg.getInt(0) >>>;
            if( note_offs[msg.getInt(0)] != null ) note_offs[msg.getInt(0)].signal();
        }
        else
        {
            <<< "Unhandled event at address", msg.address, "type", msg.typetag >>>;
        }
    }
}
