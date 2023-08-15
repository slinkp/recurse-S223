public class NoteOffEvent extends Event
{
    time started; // So we can track age
    Event finished; // So we can tell when the note has really stopped.
    int steal; // 0 = allow to decay, 1 = steal
}
