// declare event
Event e;

// function for shred
fun void eventshred( Event event, string msg )
{
    // infinite loop
    while ( true )
    {
        // wait on event
        event => now;
        // print
        <<<msg, "in", me>>>;
    }
}

// create shreds
spork ~ eventshred ( e, "fee" );
spork ~ eventshred ( e, "fi" );
spork ~ eventshred ( e, "fo" );
spork ~ eventshred ( e, "fum" );

// infinite time loop
while ( true )
{
    // either signal or broadcast
    if( true )
    { 
        <<<"signaling...">>>;
        e.signal();
    }
    else
    { 
        <<<"broadcasting...">>>;
        e.broadcast();
    }

    // advance time
    1::second => now;
}
