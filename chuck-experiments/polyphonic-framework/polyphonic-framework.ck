//------------------------------------------------
// name: polyphonic-framework.ck
// desc: Object-oriented polyphony with voice stealing.
// Author: Paul Winkler
// Inspired by polyfony.ck by Ananya Misra, Ge Wang
// send all complaints to /dev/null
//--------------------------------------------

// For example usage, see polyphonic-framework-osc-demo.ck

// Depends on note-params.ck, note-event.ck, note-off.ck

// Subclass this to get polyphony!
// Just override `play_one_note`.
public class PolyphonicInstrumentBase {

    // So we can control how many voices active at once (and how many shreds are running).
    4 @=> int number_voices;
    // So we can detect when all shreds busy.
    0 @=> int number_active_voices;

    NoteEvent on; // Scoped to this instrument.

    Gain output => blackhole; // You should connect this in your code.

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

    //////////////////////////////////////////////////////////////////////
    // Public methods
    //////////////////////////////////////////////////////////////////////
    fun void setup_voice_shreds(int n) {
        // Call this before using the instrument.
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

    /////////////////////////////////////////////////////////////////////////////////
    // Internal methods, don't call these
    //////////////////////////////////////////////////////////////////////////////////

    fun void voice_loop(int shred_number) {
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
            // if (note_offs[note] == off) {
            //     null @=> note_offs[note];
            // }
            null @=> note_offs[note]; // Assume this is either `off` or the release-interrupting event
            1 -=> number_active_voices;
            off.finished.signal();
            <<< now, "Sent finished.signal(), now active:", number_active_voices >>>;
        }
    }
}
