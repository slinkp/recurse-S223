
"hello from main" => string message;

<<< message >>>;

fun void handler(int shredNumber)
{
    "Inner value for shred " + shredNumber => string innerMessage;
    <<< now, "Inner message for:", shredNumber, "starts as", innerMessage >>>;

    Math.random2f( .1, .9 )::second => dur delay;
    delay => now;
    <<< now, "Inside:", shredNumber, ", message before update is:", message >>>;
    ("Updated from " + shredNumber + "!") => message;
    <<< now, "Inside:", shredNumber, ", message after update is:", message >>>;

    <<< now, "Inner message for:", shredNumber, "is", innerMessage >>>;

}

for( 0 => int i; i < 2; i++ ) spork ~ handler(i);

4::second => now;

<<< now, "Global message now is:", message >>>;
