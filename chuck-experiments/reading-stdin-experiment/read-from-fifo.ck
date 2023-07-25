// File input inspired by read-line.ck example.
// Am attempting to use a named pipe to work around the fact that chuck
// doesn't support reading from stdin.
// Assuming `fifotest` has been made via `mkfifo fifotest`:
me.dir() + "fifotest" => string filename;
// override with command line
if ( me.args() > 0 ) me.arg(0) => filename;
cherr <= "Opened " <= filename <= IO.newline();

// instantiate
FileIO fio;
// Opening READ_WRITE means the file won't be closed by another client sending EOF
// In theory this SHOULD mean we can read things written by multiple processes,
// but, in practice that doesn't seem to happen.
fio.open( filename, FileIO.READ_WRITE && FileIO.ASCII );


// ensure it's ok
if( !fio.good() )
{
    cherr <= "can't open file: " <= filename <= " for reading..." <= IO.newline();
    me.exit();
}

// Note, echoing to a file sends EOF.
// So we don't check for fio.more() because that returns false when
// hitting EOF. We want to loop forever until a specific exit command.
string line;
while( true )
{
    if ( line == "end" ) break;
    // This doesn't work as intended:
    // it stops reading after any program writing to the FIFO sends EOF.
    // Apparently, fifos are not really intended to be used in the fashion I guessed
    // where I might run multiple commands (eg `echo hello > myfifo; echo goodbye > myfifo`).
    // Also, even if that worked, am concerned that busy-wait on no input could be expensive.

    // Also, as written, doesn't currently work well with chuck's idea of time,
    // where you are either explicitly advancing time (as in this example) or
    // waiting on an _event_ (as in the midi examples).  There's no event when
    // a line arrives in a file.  There COULD be, via a custom event type that
    // we could manually trigger when we get a line, see docs:
    // https://chuck.stanford.edu/doc/language/event.html
    while ( fio.more() ) {
        cherr <= "Attempting to read a line" <= IO.newline();
        fio.readLine() => line;
        if ( line == "end" ) break;
        else if ( line == "beep" ) {
            cherr <= "Got beep" <= IO.newline();
            // connect sine oscillator to D/A convertor (sound card).
            // SinOsc s => dac;
            //////////////////////////////////////////
            // TODO: Wire up the chain before this loop, just trigger notes during loop.
            // allow 2 seconds to pass.
            // And, use events instead?
            // This keeps tone going forever.
            2::second => now;
            cherr <= "Note ended" <= IO.newline();
        }
        else {
            cherr <= "Huh? try 'beep' or 'end'. Got: '" <= line <= "'" <= IO.newline();
        }
    }
    // Typical Chuck infinite time loop. Don't want to wait too long before checking for more input though.
    // This will be more important if/when I get events working.
    0.3::second => now;
    cherr <= "Infinite time loop" <= IO.newline();
}

cherr <= "Done";
