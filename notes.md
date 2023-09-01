# Fri Sept 1

## Leetcode: blind75 up to 15

I did a basic Trie implementation and re-read part of the Sedgwick chapter
since I didn't remember much about them.
https://leetcode.com/problems/implement-trie-prefix-tree/

## ChucK polyphony

Putting this thing to bed - I recorded a demo video of the ADSR problem
so I can have something to drop into the blog post with actual audio.

I might want to re-record shorter ones with less narration.
At least I figured out how to record both system output and microphone with
blackhole + monosnap. Hard to get the levels right though, need to really crank
my voice volume.

Also hacked on the little Python note-generating script to make it easier to use w/o editing by
dropping in some arguments. As usual Argparse is nice to work with.
It's now actually getting fun to listen to running this script.

# Thurs Aug 31

## Pairing with Moritz on Crafting Interpreters

This was the most fun thing I've done all week.
Note to self: Pair more on other people's stuff!!

I spent about 2 hours pairing with Moritz on his project working through
[Crafting Interpreters](https://craftinginterpreters.com/), building the "Lox" language in Python.
Much of it was a tour of what he'd done so far and explaining how it worked.
I was pretty pleased that I was able to follow along. While touring the code
and playing with the REPL we found a bug in the interpreter code for function calls.
(It took me a while to understand the solution because I was confused about
which interpreter methods did and didn't consume the current token)

He was up to adding support for function definitions so we starting having a
try at that. We decided to skip the book example Java code and just have a go
at solving in Python based on what he'd built already. This was quite fun and
made me want to do the whole book!

## Algorithms

Briefly read about dynamic programming in Algorithms (3rd ed)
(Cormen et al) which I found in the Recurse library.
Refreshed my memory about _when_ it's appropriate, need to lock that in.

Then had to do some irritating time-sensitive parental stuff (my daughter
is starting a new school!).

## Leetcode: blind75 up to 14

Did: Valid Anagram, Valid Parentheses.
Didn't have time for anything substantial so I just banged out a couple "easy" ones.

Had a go at "container with most water" and haven't thought of anything beyond
brute force, which times out:
https://leetcode.com/problems/container-with-most-water/

Then presentations! Loved Ellen's human-vs-fly game.




# Weds Aug 30

## Daily leetcode / blind 75:

Did "missing number" pretty easily as today's warmup. This one has not one but TWO annoying "magic solutions"! I happened to spot one of them, would never have guessed the other trick.


I put off the hard problem [binary tree max sum](https://leetcode.com/problems/binary-tree-maximum-path-sum/) because if I'm going to even attempt that, I should really spend some time reviewing basic binary tree stuff - it's been a few years. Also I have a vague intuition that solving this efficiently might require either memoized recursion or dynamic programming - and that's been a few years too. Not sure how to account for being able to walk _up_ the tree as long as you don't cycle.

Maybe I want to spend some time revisiting algorithms. I shied away from that kind of study during my first 6 weeks because it's in the "things i'm *supposed* to know" category, but I'm finding it more fun/exciting stretching the comp sci part of my brain.

## System design interview prep group

Am really liking this group. We went through a "Design S3" challenge and had great discussions. Good to stretch these slightly atrophied muscles.

Spent some time after that skimming through the amazing [Jepsen series of posts](https://aphyr.com/posts/281-jepsen-on-the-perils-of-network-partitions)
from 2013. TL;DR consistency in distributed systems is hard.

## Mid-batch mixer

Good breakout sessions. One topic was "What's been challenging".
Had a good discussion with Erika and Moritz.

Moritz idea #1: Recreate "impossible things" day solo - just do as much as possible in 1 day.

Moritz idea #2: just say "I didn't do it" to let go of the emotional charge, and pivot to something else.

Erika idea: very small chunks, max 1 hour: eg how she did https://erikarow.land/notes/stuff-i-learned

Also met variously w/ Viraat, Doron, Kathryn, Liz. Did I forget one?

## Scheme

I wrote the `leftmost` function on pp 87-88 in The Little Schemer to cap off my day. I didn't have time left to try something ambitious, but it was good to refresh what I learned of scheme in July and do another function.


# Tuesday Aug 29

Today attended the Backend Career Switchers panel, which was interesting and I
think I had comments that were helpful to a few folks in chat, that felt good.

Resolution for tomorrow: Offer to pair with other recursers on *their*
projects. I have not been doing that and I think I am missing out by depriving myself of that generosity.

Coding: I did 4 more "Blind 75" leetcode problems, my total is now up to 11.
(Today: Reverse Linked List, Number of 1 Bits, Construct Binary Tree from
Preorder and Inorder Traversal, Reverse Bits (in C!)).
It was fun to try some bit twiddling in C after not having done that forever.
Also had to look up preorder and inorder traversal as I had no memory of what
either of them means. I accidentally saw a good starting clue while looking at
that. I was a bit astonished that my solution worked.
It uses extra memory that I maybe could have avoided by passing around a bunch of
indexes instead of building temporary sub-lists, but by that time I wasn't feeling like it :-)

Maybe tomorrow I will try something other than leetcode.
I may do fewer problems per day as warmups.

# Monday Aug 28 (revised)

Back in NYC! Feeling a little better.

Attended "Careerist Crud Accountability Hour" and added a lot from latest job
to resume. Now it has all the content, but it's too long and needs a ton of
edits. Current ResumeWorded score: 43! :-p

I also did a recursive attempt at the "Merge K sorted lists" problem from Friday.
It was fun and passes test cases, but not surprisingly, it times out.
I believe it's O(N*K) where K is number of sublists and N is average length of
sublists. https://leetcode.com/problems/merge-k-sorted-lists/submissions/1034301344/

I don't seem to have any brain cells for project-style work, so I'm banging through more
leetcode problems specifically the ["blind 75" list on
neetcode](https://neetcode.io/practice).
I got 6 working today 
(Contains Duplicate,  Valid Anagram, Two Sum,  Group Anagrams,  Top K Frequent
Elements,  Product of Array Except Self), though I needed to ask for a hint for "Product
of Array Except Self" on Zulip (in the `current batches > Daily Leetcode!` stream).
(I could not think of any O(N) way to do it without division.
Note to future self: Look for clues in specific wording of constraints.)

Also, I've done TwoSum before, but I wanted to find an O(N) solution after
having only done an O(N^2) solution before - and I did, eventually!

## Why leetcode now?

- It's giving me some "oh, I remember now that I'm smart-ish" energy after
  feelign stuck lately. I need wins!
- I might as well start challenging that side of my brain which I'll probably need for job interviews.

I may drop by the [after-hours music programming session]() later if I'm not too tired.
(Update: Nope, was too tired. Jet lag is real!)

# Fri Aug 25

Slacking off on updates again.
This is two pretty cruddy weeks in a row. I half-seriously considered quitting
Recurse because of how discouraged and stressed I've been feeling.

Still haven't finished the promised blog post because it's very long and wordy and feels
too boring to post without a big edit. I'd like more demo videos on it.

At least my COVID is gone.

Today, unsure what to do, I tackled a "hard" leetcode problem, 
[Merge K sorted lists](https://leetcode.com/problems/merge-k-sorted-lists/submissions/).

I solved it, but my [first
attempt](https://leetcode.com/problems/merge-k-sorted-lists/submissions/1031695871/),
while I initially thought it was clever, wasn't very optimal (called `sort()` many times).

My [second](https://leetcode.com/problems/merge-k-sorted-lists/submissions/1034216230/)
was both simpler and performed a lot better. Basic approach was to 1) flatten and 2)
sort() once, since python's [timsort
algorithm](https://en.wikipedia.org/wiki/Timsort) can already take good
advantage of sorted runs within a list. And indeed this beats 92% of Python
submissions.
I'm sure there is a more comp-sci-wizard approach to this though.

Cost of extra K*N memory though, since we need to build a list of all values in
order to sort.



# Tues Aug 22

I feel physically better, and I *think* I am thinking ok, but my motivation is
shot. Everything worth doing feels hard, and everything easy enough to do feels pointless.
Where's the edge of my abilities currently?

The software I want to build seems likely to require a lot of fiddling with
visuals that I *just don't care about and don't want to do*.

# Mon Aug 21

Side quest success: I was able to record some demo videos with system audio
by installing Blackhole on the mac. Various stumbles on the way.

Tested positive for COVID on Saturday. 
Good thing I was not at the hub last week.
Taking things easy today.
I felt pretty cruddy over the weekend. Improving now maybe?
I think this a separate thing from whatever I had last weekend? Who knows.

# Week of Aug 14 - 18

This was a really difficult week. I made very little progress.
I didn't write any updates from embarassment.

Back in Portland. I seem to be sick on top of jet lag. Negative COVID test.  A
*lot* of difficult personal stuff going on in my life.  I spent much of the
week tired, depressed, and anxious.  Could not get started at a reasonable
time, couldn't focus once I did get started.  Not one good night of sleep.  I
felt physically better mid-week, then worse again Friday.

I hacked some more on chuck polyphony, which has been interesting but I'm not
sure how close it's getting me to where I want.

My biggest output this week was drafting a big blog post about the ChucK work.
I also took some (paper) notes on where I'd like my music-game experiments to go.
The blog post turned into a big time sink; writing is hard, and I think I'll be
happy with it, but I wish I'd got more actual programming done.

Also experimented with brute force setting polyphony to enough voices to cover
all possible pitches (in MIDI anyway) at once. This works surprisingly well and
is probably fine for most purposes. But now I'm down a rabbit hole on a problem
that is challenging and fun!

# Fri Aug 11

Travel day, hacking on plane!
Much progress on OOP approach in ChucK. I can now have multiple instruments
working correctly dispatched from note events in a simple main loop.

Discovered that natural release after note-off still isn't working well.
When I attempt to steal a voice that's already started the final release phase
of an ADSR envelope, it just plays until release ends and _then_ starts the
next note, which throws off timing of everything.
I got a suggestion from the [ChucK
discord](https://discord.com/channels/1100930911186468894/1139410540876275752/1139557489772331118),
and spent much of the flight experimenting with that approach, but no joy yet.

# Wed Aug 9, 2023

Forgot to update yesterday so this is two days!

TODO: There's a really handy `Patch` plugin for chuck which allows wiring
audio-rate control signals eg LFOs directly to parameters of other ugens. This
avoids a lot of headache with sporking a controller shred.
Example here: https://github.com/ccrma/chugins/blob/main/Patch/Patch-example.ck

## Chuck progress

- Figured out why osc-polyphony.ck was dropping notes under heaviest load.
  It wasn't a timing bug, it was a one-character logic bug! I hadn't realized it was possible
  to have ALL current notes have a start time of `now`.
  Change `<` to `<=` and all is well.


- Updated osc-polyphony.ck to handle instruments with a note-off eg ADSR.

- Wrote a trivial synth to demo that.

- Much refactoring and cleanup for readability.
  Also made it easier to swap "instruments".

- Updated python OSC client `udp_osc_client.py` to drive chuck demo harder
  (and also sound nicer).

- Working on making ChucK polyphony more general with an OOP approach to make it
  a lot easier to reuse with multiple synth designs.
  Big refactor. Currently buggy.

# Mon Aug 7, 2023

- Went to Careerist Crud, had not done that before. I am going to attend this
  weekly. Had a look at my resume, YIKES it's 4 years behind.
  Started adding Shopify stuff to it.
  Tried the recommended resumeworded.com free trial and scored
  48/100. That's ... some room for improvement.

- Went to intro meetings and met some Fall 2 folks!

## ChucK scope experiments

This little script experiment clarifies some things about scope and timing in ChucK:

```
"hello from main" => string message;

<<< message >>>;

fun void handler(int shredNumber)
{
    "Inner value for shred " + shredNumber => string innerMessage;
    <<< now, "Inner message for:", shredNumber, "starts as", innerMessage >>>;

    // Delay a random amount of time.
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
```

If I run this, the output looks like:

```
$ chuck scope-test.ck
[chuck]: cannot bind to tcp port 8888...
"hello from main" :(string)
0.000000 Inner message for: 0 starts as Inner value for shred 0
0.000000 Inner message for: 1 starts as Inner value for shred 1
10389.385197 Inside: 1 , message before update is: hello from main
10389.385197 Inside: 1 , message after update is: Updated from 1!
10389.385197 Inner message for: 1 is Inner value for shred 1
24469.943342 Inside: 0 , message before update is: Updated from 1!
24469.943342 Inside: 0 , message after update is: Updated from 0!
24469.943342 Inner message for: 0 is Inner value for shred 0
176400.000000 Global message now is: Updated from 0!
```

From this I deduce:

- Global variables are really global, not thread-locals.
  Updating a global var from inside a shred updates it for everyone.
  Last write wins.

- Inside a shred, the shred has its own view of "now", always. Advancing time
  in one shred doesn't affect the logical state of others - but time is funny, because
  there's truly only one "now".

- But something in the _main_ shred needs to advance the global time in order
  for child shreds to advance! If I remove the `4::second => now;` line near
  the end, then _nothing happens_ and we never get past "hello from main".

## ChucK Polyphony next steps: How to write LRU in chuck?

Kind of weird about current design: `note_offs` is indexed by _note_ but shreds
are not note-specific. This prevents ever modifying the design to multi-trigger
the same note, which sometimes might be desired. It does satisfy receiving
arbitrary note-off messages, though.

So:

Create a custom `note_off` type with a `start_time` attribute.

Add a global var `numberActiveVoices` and initialize to zero.

In handler:
  Set `note_off.start_time` to now.
  At start of loop, increment global `numberActiveVoices`.
  At end of loop, decrement global `numberActiveVoices`.

In main loop when receiving a note:
- Current logic: check for `note_offs[note]` and signal if it exists
  (ideally we should wait for `note_offs[note]` to be null, and ideally lock)
- if `numberActiveVoices` == number of shreds:
  - find event in `note_offs` with _minimum_ value of `start_time`
  - signal that event

There are likely race conditions though. We might drop a note if we think we have
one free voice but then start two voices at the same time? Or free two voices
when we only need to free one?

So... that worked out pretty well!

But I noticed when testing with polyphony of 1, that only every other note was
triggering now. Hmm, weird.
On reflection and much staring at output printing, it occurred to me that maybe we were _always_ trying to start the
next note before the existing one finished its cleanup and re-entered the
handler loop.

To fix, I ended up adding _another_ event to cut down on race conditions: the
`noteOffEvent` grew a `callbackEvent` attribute so it could signal back to the
main thread when it was done; this way the main thread can wait for _that_ and
thus avoid trying to start the next note before the voice is ready.

That done, I can now add balls to the Godot game as fast as I can click without
_ever_ getting the Chuck process stuck, regardless of polyphony setting. Pretty cool.

# Sat Aug 5, 2023

This might turn into a blog post.

Okay, now I _actually_ figured out the polyphony voice starvation problem in my
ChucK synth program.

It's a concurrency problem. And maybe one that's obvious to anyone who's
manually written concurrent code with a thread-pool approach - but I never
have!

It's interesting to realize that I have almost never written explicitly
concurrent code. Web backend software so often means using a framework that
gives you a "shared nothing" experience where all you care about is a method
handling the "current" request and you're not mucking around with actually
wiring up multiple concurrent requests to threads or processes. That happens at
a higher level that you mostly ignore when working on application code.

The one exception was ten years ago when I was writing async code at Bitly
using (a very old version of) Tornado, which I have mostly forgotten, aside
from the general challenge of understanding "callback hell".

So, in the [midi polyphony
example](https://chuck.stanford.edu/doc/examples/midi/polyfony.ck) that I used
as my starting point, there is a pool of threads - ChucK uses the "funny" name
`shreds` for threads.  Each one can make one "voice" or note at a time.  The
lifetime of a note is one iteration through the infinite loop in the `handler`
function.

The `off => now;` line in the `handler` function looks weird; 
it causes the `shred` to continue processing samples (perhaps silently)
until that `off` event is signaled, otherwise, forever.
This might be analogous to `await off` in some async languages.

This is true even if, as in my example, the note's amplitude has been reduced
to zero in a relatively short time. The shred is still busy waiting for that
event even if you don't hear anything.

So to free a voice and let it start a new note, we need to signal the `off`
event instance which _that specific voice_ registered in the `note_offs`
array. This lets the `handler` function proceed to the end
of its loop iteration, go back to the beginning, and start a new note.

In my first version, as in the midi example, note off was happening one of two ways:

- In the `/note/off` message handling, but that was written speculatively - so
  far my Godot client was never sending those, and in general a MIDI or OSC
  client can never assume note-off will be sent.  Clients get buggy, hardware
  gets "stuck", transports drop events, etc.
  As long as the client is perfect, and eventually stops all notes that it
  started, we'd be OK!

- At the beginning of `handler`, I added a check to see if there is already an `off`
  registered for this pitch, and signal it if so.

The latter meant we will only ever have at most one handler processing a given
pitch, so if you send a duplicate pitch, the idea was to free the shred
that's already playing it, so you'll have one free.
However, it's a naive approach because you have to _already_ have a free shred
available in order to get that far in the code and signal one to stop.

This meant the number of busy shreds was always equal to the number of _unique pitches_ received so far.

To see this, imagine a degenerate case, where we set the number of shreds to 1.
In that case, as soon as you receive one pitch and start handling it, Chuck
will keep running that shred waiting for note-off forever. If the client never
sends note off for that same pitch, you can never play another note.

If we set the number of shreds to 2, the same state happens after 2 _unique_
pitches are received.
What if we graph the note being played by each shred, with blank cells representing
shreds that are not busy _after_ that note is received, and `^^` representing
a shred that's still handling the note from the previous line?

Imagine this sequence of notes: `60, 60, 62, 60, 51`
And imagine the client never sends any "note off" events.

With the example in `midi/polyphony.ck`, that graph would look like:

| note | shred 0 | shred 1 |
|------|---------|---------|
| 60   | 60      |         |
| 60   | ^^      | 60      |
| 62   | ^^      | ^^      |
| 60   | ^^      | ^^      |
| 63   | ^^      | ^^      |

Whoops. This is pretty bad.

With my first "improved" version, as described above, it would look like:

| note | shred 0 | shred 1 |
|------|---------|---------|
| 60   | 60      |         |
| 60   |         | 60      |
| 62   | 62      | ^^      |
| 60   | ^^      | ^^      |
| 63   | ^^      | ^^      |

This is marginally better - we don't accidentally play pitch 60 on two voices
at once, and we get as far as starting to play pitch 62 - but then we're stuck.

Either way, in order for this crude polyphony to work, we'd need a number of voices
(shreds) equal to the total set of possible pitches. Oops.

## We fixed it! Right?

Not so fast.

The fix I made in b3214c48cc6585bd126f7109d451c119baddc170 only moves the check
for existing `note_off` events into the "main" shred.  This is another slight
improvement, becaues we don't have to have a free shred available in order to
stop an existing one playing the same note.

But let's consider the same sequence of notes:

| note | shred 0 | shred 1 |
|------|---------|---------|
| 60   | 60      |         |
| 60   |         | 60      |
| 62   | 62      | ^^      |
| 60   | ^^      | 60      |
| 63   | ^^      | ^^      |

The only improvement in this simple case is that we got as far as triggered the `60` on the
fourth line. We still dropped the final note `63`.
And we'll never be able to start any other note that isn't 60 or 62.

The reason I thought it was fixed was that, in practice, with a limited set of
pitches (I was using a 2-octave range so 24 pitches) and a large-ish set of
shreds (I was using 20), it's clearly _better_ - it means we play _most_
of those notes. But we still drop some; as long as there are fewer shreds than possible
notes, without explicit note-off events, there will be pitches we can never
play.

## Can we do better?

I think the behavior I am really looking for here is like an LRU cache.
Apparently, synth manufacturers and musicians know this as "voice stealing".

When a note arrives, if there are no free voices, we should free the one that's been
playing the _longest_. Even if that means cutting off a note that's deliberately
sustaining, that's likely better than dropping a new note entirely.

I can imagine ways to do that. Something like, keep a reference to the oldest
playing shred, and when there are no free shreds, forcibly free that one and
set it to the next-oldest one.
Am trying to think of the best data structure for this. I think I need to know
how scoping works in Chuck across shreds (this is ambiguous to me currently). Are global
vars actually shred-local?

If I get this working, it should be easy to test. In the degenerate case of one free
shred, we'd have something like a monophonic keyboard. Any note received stops any
playing note and takes over.

If I get this working, I'd like to submit an example to the Chuck docs, because
the midi example that I copied my buggy approach from is problematic, and it might be
hard for people to figure this all out on their own.

# Fri, Aug 4

- Never-graduate picnic

- Read a bunch of really interest blog posts by recursers

- Fixed my polyphony bug in my chuck script. That was an interesting
  concurrency logic bug, maybe worth presenting.
  - I still don't 100% understand the sequence of events that led to
    the starvation state as of 9df71ec6efe76c2f15fcdc902ff50cc603da56c2,
    though I understand why the fix worked.

    In the old code, the "free a previous voice already playing this note"
    check happened inside a voice handler. So assuming we can get into a
    state where all shreds are waiting for "note off", then you wouldn't ever
    run the code that frees a busy one because there's a catch 22. This part
    was easy to understand.  And the fix was just to do that check in the main
    shred, not in a handler, which pretty obviously just works.

    The part I don't understand is what sequence of notes would lead to them
    all being busy. It's probably simple, since it happens relatively quickly
    in a demo.

    I should think through the buggy state and write that up. Blog post!


# Thurs, Aug 3


- Career stuff: Met with Rhea about what it was like working at jane street.
- Godot engine: Experiment with adding another wall to the game with a
  different effect (chorus & phaser) and fixed an error in yesterday's
  refactoring where only the last configured audio player was used.
- Went to presentations & never-graduate niceties
- Went to happy hour, played pictionary. Could not draw the word "Try" :-o


# Wed, Aug 2

I have decided I am going to extend 6 weeks. The first 6 have come and
gone in a flash.

- Met with Sonali about extending recurse, job market, salary market, all the
  scary stuff. Very very helpful.

- Talked to Thelma, learned a bit about the browser building project, it seems
  both very intense and very approachable, impressive.

- Noticed the "Careerist Crud" chat stream and, as leetcode-grinding is
  somewhat in the back of my mind, got interested to see what they're up to.
  Somewhere I saw mention of the "grind 75" list of problems
  [here](https://www.techinterviewhandbook.org/grind75)
  and had a go at "two sum". Solved it in python in about 10 min (including a false
  start) but it was brute force. I didn't take time to think about better algorithms.
  Boy am I rusty at this kind of thing.

- I played around with filters in Chuck and got more interesting sounds by
  playing with the filter bandwidth (Q).

- Paired briefly with Nolen re better organization for my Godot code.
  He introduced the "Call down, signal up" principle to me,
  found a description here:
  https://kidscancode.org/godot_recipes/4.x/basics/node_communication/index.html

  - It took me a minute, but Nolen's suggestion worked, allowing me to move
    all the audio handling to a top-level generic Node.
    Ball `_on_body_entered` is still what gets triggered on collision; from
    that we dispatch `on_hit` with args including the position and body (wall).

- Attended non-technical talks and presented about RSU comp at public companies

# Tuesday, Aug 1

Kind of a lost day.

- Distracted by personal stuff

- A bit of cleanup on yesterday's Chuck instrument.

- Writing yesterday's update

- Far too long writing for tomorrow's non-technical talks (I was requested to
  present on RSU compensation as a followup to last week's talk on startup
  stock options). I thought I had less to say about this topic.
  Ha ha! I have a TON to say about this topic. It was fun and hopefuly valuable
  to folks tomorrow.

- Met briefly w Mai about panicky feelings re continuing recurse for the full
  12 week batch vs starting job search ASAP.

- Booked a meeting w Sonali tomorrow about the same.



# Monday, July 31, 2023

I spent much of today attempting to port a peculiar-sounding and clever Csound
instrument to ChucK.
This helped me understand Chuck a lot better.
And I even dug into the C code for Csound to try to understand the behavior of
some of its features, namely the `ampdb` converter, which I eventually realized
had an equivalent in Chuck `Std.dbtolinear` and that what I really wanted was
the related `Std.dbtorms`.

(My apologies to folks at the Hub who were treated to my laptop blasting out a
burst of incredibly loud noise before I caught the difference between the two.
On the other hand, my ears are lucky I was not wearing the earbuds at that moment.)

I still feel like I am not 100% comfortable with Chuck's idiosyncratic handling
of time.  I did figure out how to wire up things like controlling audio gain
_at audio rate_ - you can't plug a unit generator directly into eg `Oscil.gain`
but you _can_ "chuck" multiple signals to eg a `Gain` instance in multiply mode, where
it multiplies all its inputs every sample.

The instrument doesn't sound good though. There's no native equivalent of the
critical csound `randi` generator, which linearly interpolates between random
numbers generated at a specified interval.  The intent is effectively a noise
with some high frequencies filtered out, which theoretically could be done by
piping Chuck's `SubNoise` (equivalent to Csounds's `randh`) into a low-pass
filter of some sort, but I haven't found a filter that sounds even remotely like it.


# Fri July 28, 2023

## Progress: Godot sending OSC -> UDP -> Chuck ... it beeps!

Continuing from yesterday: Spent a couple hours banging my head around how to
format proper OSC messages from Chuck. At first I thought this meant using a
`PackedByteArray`, but then I discovered no way to serialize an integer into a
signed _bigendian_ int as required by OSC... except to use
`StreamBufferPeer.put_32`. That class basically wraps `PackedByteArray`.

It seems like more overhead, conceptually if not performance-wise, but maybe
it's not surprising that the only place Godot exposes endianness is in what's
intended to be low-level networking code.

I had it producing messages where the bytes that I sent to the logger looked
correct (though that took some eyeballing ascii codes as I didn't know a quick
way to make them more readable; gdscript is not as nice as Python about things
like that), but my Chuck script was still complaining that they were invalid
OSC messages.

Then I discovered I had left in a later call to `append(1)`
that I temporarily added when I first minimally tested UDP :facepalm:

I removed that trailing byte of garbage and now ... it beeps!

I need to figure out how to record screen captures with both video and system audio.

## TODO

What next? I think the remaining work is to make this thing actually
interesting/fun, as it's currently only a proof of concept.

Also, it occurs to me that the polyphony demo could be more robust about voice
starvation. Instead of depending on the client to reliably send note-off
messages: Every time we start a note, we check if there's a note-off signal
already registered for that pitch, and signal that if not null.

# Thurs July 27

Ok, maybe _not_ middleware. After talking to recursers Nolan and Andrew,
apparently it's easy to send OSC via raw UDP.

Setting Haskell aside for now...

## Progress:

- I wrote a trivial Python osc client demo with some trial and error to get the byte
padding right, and confirmed the Chuck osc-dump.ck demo can receive and parse
it.

- I modified the [Chuck polyphonic MIDI example]() to receive OSC, which
involved wrapping my brain around how Chuck deals with time and signals (very
interesting and weird), and then confirmed I get actual audio when running my
python client in another terminal. It beeps! Iterated a bit to improve note-off handling.
OSC doesn't have a standard way to represent notes, so as a quick hack, I'm
just embedding MIDI integer pitch, ie 60 = middle C.

I put those scripts [here](https://github.com/slinkp/recurse-S223/tree/main/chuck-experiments/osc).

Then I started hacking on some GDScript to send raw UDP from Godot.
I confirmed it sends them, but I haven't formatted valid OSC messages yet.

# Weds July 26 2023

Finally attended one of Andrew's "Happy Little Sine Waves" sessions and saw how
he would build an envelope generator from scratch in Pd. 

Then I got back to the Recurse hub. Hello hub!

## Planning

I'm pursuing the "middleware" approach described yesterday,
and somewhat arbitrarily picked Haskell as the implementation language,
because:
- I'd like to learn Haskell!
- It's functional!
- It already has libries for both OSC and Websocket.


0. First step: Make a plan
  - [x] That would be this.

1. Make chuck beep from haskell repl
  - [x] Side quest: Learn haskell. Semi-joking. First I need to do a small hello world haskell tutorial
  - [ ] install haskell OSC library
  - [x] find or hack a Chuck demo that listens for OSC events
  - [ ] write a function to send an OSC event and call it from haskell repl
  - [ ] confirm i can make chuck beep from haskell

2. Ping haskell from godot via websockets
  - [ ] Install haskell websocket library
  - [ ] Decide which is the client and which the server.
    - first idea: game should be the server and audio should be a client.
      This would eventually allow running a multiplayer game server with different clients
      each running the sound engine locally. Each player hears something
      different? This is more useful for the "mixer space" idea I wrote up on 7/11/23.
    - This might be the wrong way to think about it though. Maybe the audio
      engine always talks to the local game client (which is also Godot), not the
      godot server.

3. Profit. Or, rather, have fun making noises.

4. Optional: Bypass websockets and embed the haskell stuff in godot?
  - There are [Haskell bindings for GDNative](https://github.com/SimulaVR/godot-haskell)
  - Unclear if that means I could use the haskell OSC sources from directly
    inside godot?
  - If so, then instead of using websockets at all, we could presumably have haskell
    functions that send OSC to an audio engine, and trigger those functions
    directly from godot signals.

## Progress

Well, I learned a tiny bit of Haskell tutorial, and a bit more Chuck.

# Tues July 25 2023

Not back at hub. Too tired, I slept poorly.
I did manage to have a fairly useful day of discoveries, though none of it is
tangible progress on the bouncing audio game:

## FIFOs and chuck: learned a lot, moving on

Yesterday's progress:

I started getting a handle on the [Chuck language](https://chuck.stanford.edu/doc/)
and spent some time investigating whether I could make it beep via events on
stdin.

Answer: Not really. Chuck doesn't support stdin :(
It does of course support reading lines from a file, and I have a hacky attempt
at using a named fifo on the filesystem (via `mkfifo`).
Which sort of works, but the process writing to it needs to keep it open; once
you send EOF, chuck will never see any more data. Will play with this more Tuesday.

Today's progress:

More fiddling with FIFOs, which has taught me quite a bit about FIFOs!
First of all, confirmed that Chuck will never see any more data from a FIFO
after receiving EOF.

I thought I had learned of a workaround which in hindsight is both clever and retroactively
obvious: A script that wants to read a FIFO can open it in read/write mode.
The FIFO should be kept open as long as it has *at least one* writer.

But... this still didn't work. Chuck won't read any lines after EOF from the
first write.
I committed all this to a new repo for my chuck experiments (TODO: add link)

Maybe the open-for-both-read-and-write trick is a Bash-ism as that's the context where I learned
of it?
It does seem to work in bash, eg:

in one terminal:
```
mkfifo foo
exec 3<>foo
cat <&3
```
And in the other:
```
echo hello > foo
echo hello again > foo
```
The first terminal will print both messages.


## Next try: virtual MIDI cable?

Followed this: https://feelyoursound.com/setup-midi-os-x/

Chuck can see the virtual midi cable; partial output of `chuck --probe`:

```
[chuck]: ------( 3 MIDI inputs  )------
[chuck]:     [0] : "Revelator IO 24"
[chuck]:     [1] : "IAC Driver Bus 1"
[chuck]:     [2] : "IAC Driver Virtual MIDI Cable"
```

### Success: a chuck script sending midi through virtual midi cable to another chuck script

I successfully got both the `gomidi.ck` example (for reading)
and the `midiout.ck` example (for writing), only had to slightly tweak the
latter to un-hardwire midi channel 0.
Committed scripts for this to my chuck experiments repo too. 
Example output:

```
Pauls-MBP midi:(main)$ ./main.sh
Here are two chuck programs sending midi to each other via virtual midi cable.
This assumes that midi device 2 is that virtual midi cable
Example of how to set one up on MacOS: https://feelyoursound.com/setup-midi-os-x/

If it's working you should see both 'sending' and 'Received' messages printed

[chuck]: cannot bind to tcp port 8888...
MIDI device opened for reading: 2  ->  IAC Driver Virtual MIDI Cable
MIDI device opened for writing: 2  ->  IAC Driver Virtual MIDI Cable
sending NOTE ON message...
Received  144 60 127
sending NOTE OFF message...
Received  128 60 0
sending NOTE ON message...
Received  144 60 127
sending NOTE OFF message...
Received  128 60 0
sending NOTE ON message...
Received  144 60 127
```


## Godot sending MIDI output ... Nope :(

Well, somehow I missed that Godot doesn't send midi at all. Input only. Geez.
I wouldn't have done the previous experiment if I had bothered to confirm this
first.

There is an [open issue about
it](https://github.com/godotengine/godot-proposals/issues/2321) but nobody has tackled it.
Another side quest I'd like to avoid; if I were going to do this I'd do OSC instead.

## Re-assessing Godot output control signal options

I could either still attempt the embedding route ...
OR attempt the middleware route, Godot makes network requests to a separate process
which is responsible for receiving them and translating them into something a
synth engine (eg Chuck) can understand.

### Middleware protocol options

Godot can send/receive either http, websocket, or webrtc. That's pretty much it.

Webrtc doesn't seem very helpful in this context?
Http works but is a fair amount of overhead.
Websocket seems like a suitable transport layer and **bonus: i'd get to finally learn how to
work with websockets.** More learning = more good.

Something like:

```
+------------+              +----------------+             +--------------+
| gdscript   |  websocket   | middleware     |  OSC        |Synth engine  |
| function   |------------->| reads events   |------------>| (eg chuck,   |
| sends data |              | and translates |             | Pd, faust,   |
| as packets |              | to ... OSC?    |             | etc          |
+------------+              +----------------+             +--------------+
```

#### Advantage:

- Synth engine is more or less trivially swappable (lots of things support OSC).
- I get to learn websocket.
- I get to learn something about OSC.
- I get to pick an arbitrary language for the middleware and learn that too!
  Scheme, Haskell, something.

#### Disadvantage:

- Highly un-portable. I couldn't distribute a "game" built this way.

## Or, embedding

In this route I'd write a GDExtension that embeds Chuck.
Or try again with Faust.

#### Advantage

- I'd get to learn / re-learn a little C++, that'd be good.
- *Maybe* games written this way are portable?

#### Disadvantage

- I'd be tying to one sound engine forever.
- I think learning how to build a gdextension is less
  generally useful/portable knowledge than learning websockets and a functional
  language, aside from the general c++ experience.
- Sounds less fun and interesting.

# Mon July 24 2023

## Plan

Travel day.
TIL that United in-flight wifi is decent enough for documentation browsing at
least... and that united economy seats are *very* tight for working on a
laptop. Feel very scrunched, trying to take it easy and not hurt my wrists too
much.

Today's goal: See if my Godot game can make an external sound engine (any
external sound engine) go boop.
As a first pass, I might see if I can either wire up godot to chuck via a
virtual midi device (which I don't yet know how to set up), or - as a possibly
more fun hack - shove lines of text through a local pipe or socket, which Chuck seems
like it might be able to consume and parse.

If I can make a hello world beep, then I may try porting old weird csound code
mentioned in a previous update to Chuck and see how well I like Chuck for this
sort of thing.

But in terms of "programming at the edge of my abilities", a more useful hack
might be to make a Godot 4 extension to send OSC messages. There is an old abandoned implementation
for Godot 3, but it's incompatible and the extension interface has changed
completely between 4 and 5.
Solving this would mean diving into C++ which I have never got along well with
and haven't touched in probably 20 years. Intimidating, but also maybe empowering?

OR! Here's a wacky idea: Some kind of middleware in language of my choice that
translates .... something that Godot can already emit to OSC, and send OSC to
chuck.
Harder to distribute, but more fun to write? Could stretch my polyglot muscles
by writing the middleware in some interesting new-to-me language eg haskell.

## Progress

I started getting a handle on the [Chuck language](https://chuck.stanford.edu/doc/)
and spent some time investigating whether I could make it beep via events on
stdin.

Answer: Not really. Chuck doesn't support stdin :(
It does of course support reading lines from a file, and I have a hacky attempt
at using a named fifo on the filesystem (via `mkfifo`).
Which sort of works, but the process writing to it needs to keep it open; once
you send EOF, chuck will never see any more data. Will play with this more Tuesday.


# Sun 7/23

Tried to install various things I might want to play with on the plane on Monday, and hit
some dead ends that may inform future audio programming.

Now, what audio do I want to try on the plane?

From [The Haskell School of
Music](https://www.cs.yale.edu/homes/hudak/Papers/HSoM.pdf)
i tried installing Euterpea2. 
Sadly it seems to be abandonware. I succeeded in installing Haskell and ghcup,
but euterpea was a dead end: the suggested `cabal v1-install` doesn't exist,
instead suggests `cabal v2-install` which dies like so:

```
cabal: Could not resolve dependencies:
[__0] trying: Euterpea-2.0.8 (user goal)
[__1] next goal: bytestring (dependency of Euterpea)
[__1] rejecting: bytestring-0.11.4.0/installed-0.11.4.0 (conflict: Euterpea =>
bytestring>=0.10.4.0 && <=0.10.9)
[__1] skipping: bytestring-0.12.0.0, bytestring-0.11.5.0, bytestring-0.11.4.0,
bytestring-0.11.3.1, bytestring-0.11.3.0, bytestring-0.11.2.0,
bytestring-0.11.1.0, bytestring-0.11.0.0, bytestring-0.10.12.1,
bytestring-0.10.12.0, bytestring-0.10.10.1, bytestring-0.10.10.0,
bytestring-0.10.9.0 (has the same characteristics that caused the previous
version to fail: excluded by constraint '>=0.10.4.0 && <=0.10.9' from
'Euterpea')
[__1] trying: bytestring-0.10.8.2
[__2] next goal: base (dependency of Euterpea)
[__2] rejecting: base-4.16.4.0/installed-4.16.4.0 (conflict: bytestring =>
base>=4.2 && <4.15)
[__2] skipping: base-4.18.0.0, base-4.17.1.0, base-4.17.0.0, base-4.16.4.0,
base-4.16.3.0, base-4.16.2.0, base-4.16.1.0, base-4.16.0.0, base-4.15.1.0,
base-4.15.0.0 (has the same characteristics that caused the previous version
to fail: excluded by constraint '>=4.2 && <4.15' from 'bytestring')
[__2] rejecting: base-4.14.3.0, base-4.14.2.0, base-4.14.1.0, base-4.14.0.0,
base-4.13.0.0, base-4.12.0.0, base-4.11.1.0, base-4.11.0.0, base-4.10.1.0,
base-4.10.0.0, base-4.9.1.0, base-4.9.0.0, base-4.8.2.0, base-4.8.1.0,
base-4.8.0.0, base-4.7.0.2, base-4.7.0.1, base-4.7.0.0, base-4.6.0.1,
base-4.6.0.0, base-4.5.1.0, base-4.5.0.0, base-4.4.1.0, base-4.4.0.0,
base-4.3.1.0, base-4.3.0.0, base-4.2.0.2, base-4.2.0.1, base-4.2.0.0,
base-4.1.0.0, base-4.0.0.0, base-3.0.3.2, base-3.0.3.1 (constraint from
non-upgradeable package requires installed instance)
[__2] fail (backjumping, conflict set: Euterpea, base, bytestring)
After searching the rest of the dependency tree exhaustively, these were the
goals I've had most trouble fulfilling: base, bytestring, Euterpea
```

I don't feel like fighting that battle for unmaintained software.
Side quest averted!

Next I tried installing Faust, but the suggested `sudo make install` dies as well;
looks like some bad scripting, my first guess is something like an env var evaluated to empty string:

```
make -C build install DESTDIR= PREFIX=/usr/local
if test -d ../.git; then git submodule update --init; fi
cd faustdir &&  .. -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release "-DWORKLET=off"
/bin/sh: ..: command not found
make[1]: *** [install] Error 127
```

Chuck: install success.
`chuck --help` at least spits out nice output.
I downloaded all the docs I could find into ~/Downloads/chuck_docs for offline perusal.

Confirmed that the `foo.ck` from the STanford tutorial works.
Also downloaded that tutorial.
So, I guess Chuck it is, for my next steps at least.

# Fri 7/21

## Game tweaks

- I added a speed control, just a text input that controls speed of new balls,
  not existing ones.
- Added a MarginContainer around the controls to make layout a bit nicer, and
  figured out the basics of the GridContainer that my buttons are in.
  (It has spacing properties for laying out its children; I didn't find them
  at first because they're not called margins.)

## Pairing with Andrew Joseph Turley

Whew. I have been too anti-social this week. Partly because I am embarassed
about lack of progress.

Today I forced myself to pair (twice!) which was really good!

I showed Andrew my current toy/game and we discussed a lot, such as:

- Rapidly hitting the limits of the godot audio engine, and options.
- eg you _could_ probably build something out of primitives internally,
  but it might be difficult and not performant.
  Would be writing simple synth primitives like envelopes and LFOs from scratch.
  You can sort of imagine that from reading the [AudioStreamGenerator docs](https://docs.godotengine.org/en/stable/classes/class_audiostreamgenerator.html#class-audiostreamgenerator)
  ... but if you want polyphony you might end up doing something like
  managing a pool of buses manually, etc.
- Instead you could consider another engine entirely, eg PD, Faust, etc etc.
  Or one of the common game audio engines. I always figured I might end up this
  way. And there are broadly two ways to do that. Roughly in order of difficulty:
  - Controlling an external engine:
    - HTTP is clunky for this purpose but simple and might do for a first proof of concept.
      - [Godot can make HTTP
        requests](https://docs.godotengine.org/en/stable/tutorials/networking/http_request_class.html#why-use-http)
      - [Faust can get control values via HTTP
        requests](https://faustdoc.grame.fr/manual/http/#changing-the-value-of-a-widget)
        though all the examples are setting values of widgets like sliders,
        presumably could use for note triggers as well?
    - OSC is likely a better fit for purpose.
      - [There is an old, likely outdated OSC client extension for
        Godot](https://github.com/frankiezafe/gdosc)
        - ok, that's a large yak to shave: it's a GDNative extension. Godot no longer
          supports that; it would have to be rewritten as a GDExtension.
      - [Faust can receive OSC
        messages](https://faustdoc.grame.fr/qreference/7-osc/#osc-support)
      - [PD can as well]()
  - Embedding an engine:
      - [PD or rather libpd can be embedded in
        godot](https://github.com/magogware/godot-audiostreampd), this means
        you can have godot run an existing pd patch as an embedded audio stream.
      - It may be possible to do the same with faust?
        Unclear. Certainly you can compile faust to C or C++ and then there may be
        some way to write a program that bridges that to a Godot audio stream.
        But it may mean recompiling anytime you change the Faust dsp code.
        Initial reading suggests that [dynamically loading faust dsp source at
        runtime is supported only in certain platforms](https://faustdoc.grame.fr/manual/embedding/):
        > The Interpreter, LLVM IR and WebAssembly ones are particularly interesting
        > since they allow the direct compilation of a DSP program into executable code
        > in memory, bypassing the external compiler requirement.


## Pairing with Cody Harris

Learned a bit about cryptopals, what an "oracle" is and how he made a simple
one, really neat example.
We talked through my godot project. Didn't write code. But he had some good
feedback and we talked about the pain of building user interfaces.

## Random side note re a lost cool old csound instrument

Long ago I translated an example from Dodge's "Computer Music" book into
Csound. I still remember what it sounded like, but not how it worked.
It seemed pretty simple but also strange - using random noise in a weird way
that produced a sort of rumbly or blurry pitch.
I liked how it sounded and the range of sounds that could
be made by tweaking the parameters. I remember using it in my earliest
experiments with python-generated csound scripts.

I also remember that that same demo of mine used a PWM synth that I wrote and
was proud of, and somebody else's drum that made nice kicks.

Sadly this does not seem to be anywhere on my current computer, nor in dropbox,
which is supposed to contain "everything".
I have a pile of ancient backup drives, which hopefully still work, and this
thing _should_ still exist on one of those.
If I can find it, I would love to translate those instruments into something I
can use with my project, whether Faust or Chuck or other.

UPDATE: I found it! In dropbox after all, just inside an old tarball.
The python code was called "pysco" and the files were named `song1.orc` and `song1.sco`.

Excerpt of song1.orc below.
I believe the referenced "table 1" is supposed to just contain a cycle of a sine
wave.

```
instr 1; variably noisy pitched ring modulator
; by PW based on C. Dodge (2nd ed.) p. 103

;set up an envelope
  idur  =       p3-p4-p5
  iamp  =       ampdb(p6)
  kenv  expseg  1, p4, iamp, p5, iamp, idur, 1

; set up note freq & noise bandwidth
  ipitch        =       cpspch(p8)
  ibw   =       .01*p7*ipitch   ; p7 sets noise bandwidth as % of ipitch

;feed amplitude kenv into a random # generator
  amp   randi   kenv, ibw

; random # modulates amp. of oscillator
  aout  oscil   amp, ipitch, 1  ; use table 1
        outs    aout, aout
endin
```

And here were some note events for it, and the f1 table from the .sco file:

```
f1 0 65536 10 1

;     start         duration       atk rel   db   bw   octave.pitch
i 1.0 25.9459459459 0.430947295709 0.1 0.001 76.0 10.0 7.0
i 1.0 26.2757884206 0.169059850097 0.05 . 79.0 12.0 7.02
i 1.0 26.4448482707 0.241319036428 0.02 0.1 81.0 8.0 7.03
i 1.0 26.5820826849 0.279766252739 0.2 0.001 83.0 7.0 6.09
i 1.0 26.8264918855 0.35853685648 0.01 . 66.0 10.0 8.09
i 1.0 27.0402896433 0.665231682917 0.005 . 73.0 15.0 8.1
i 1.0 27.3315336488 1.98030139423 0.005 0.1 78.0 30.0 8.07
i 1.0 28.0905453044 2.09066440118 1.0 1.0 90.0 80.0 5.06
i 1.0 28.648119859 2.16791850605 1.5 2.0 37.0 60.0 11.05
i 1.0 28.8113999428 3.14324165529 1.0 2.5 33.0 60.0 11.08
i 1.0 29.0179832153 0.209342347636 0.3 0.001 60.0 10.0 10.09
i 1.0 31.9546415981 0.643285721091 0.1 0.001 76.0 10.0 7.0
i 1.0 32.4478213231 0.250728475244 0.05 . 79.0 12.0 7.02
i 1.0 32.6985497983 0.355655111633 0.02 0.1 81.0 8.0 7.03
i 1.0 32.9011191126 0.410436052974 0.2 0.001 83.0 7.0 6.09
i 1.0 33.2598643885 0.521874106774 0.01 . 66.0 10.0 8.09
i 1.0 33.5716644965 0.959238733446 0.005 . 73.0 15.0 8.1
i 1.0 33.9935783022 2.7969876457 0.005 0.1 78.0 30.0 8.07
i 1.0 35.0792644583 2.90735065265 1.0 1.0 90.0 80.0 5.06
i 1.0 35.8655111633 2.98460475752 1.5 2.0 37.0 60.0 11.05
i 1.0 36.0941261473 4.28660240734 1.0 2.5 33.0 60.0 11.08
i 1.0 36.3823780449 0.291010972782 0.3 0.001 60.0 10.0 10.09
i 1.0 40.3807285546 0.855624146473 0.1 0.001 76.0 10.0 7.0
i 1.0 41.0372455299 0.332397100391 0.05 . 79.0 12.0 7.02
i 1.0 41.3696426303 0.469991186839 0.02 0.1 81.0 8.0 7.03
i 1.0 41.6375468447 0.541105853209 0.2 0.001 83.0 7.0 6.09
i 1.0 42.1106281958 0.685211357068 0.01 . 66.0 10.0 8.09
i 1.0 42.5204306539 1.25324578397 0.005 . 73.0 15.0 8.1
i 1.0 43.0730142599 3.61367389716 0.005 0.1 78.0 30.0 8.07
i 1.0 44.4853749166 3.72403690412 1.0 1.0 90.0 80.0 5.06
i 1.0 45.500293772 3.80129100899 1.5 2.0 37.0 60.0 11.05
i 1.0 45.7942436561 5.4299631594 1.0 2.5 33.0 60.0 11.08
i 1.0 46.1641641789 0.372679597929 0.3 0.001 60.0 10.0 10.09
i 1.0 51.2242068155 1.06796257186 0.1 0.001 76.0 10.0 7.0
i 1.0 52.0440610411 0.414065725538 0.05 . 79.0 12.0 7.02
i 1.0 52.4581267666 0.584327262045 0.02 0.1 81.0 8.0 7.03
i 1.0 52.7913658812 0.671775653444 0.2 0.001 83.0 7.0 6.09
i 1.0 53.3787833074 0.848548607362 0.01 . 66.0 10.0 8.09
i 1.0 53.8865881157 1.5472528345 0.005 . 73.0 15.0 8.1
i 1.0 54.5698415219 4.43036014863 0.005 0.1 78.0 30.0 8.07
i 1.0 56.3088766793 4.54072315559 1.0 1.0 90.0 80.0 5.06
i 1.0 57.5524676851 4.61797726046 1.5 2.0 37.0 60.0 11.05
i 1.0 57.9117524693 6.57332391146 1.0 2.5 33.0 60.0 11.08
i 1.0 58.3633416172 0.454348223076 0.3 0.001 60.0 10.0 10.09
i 1.0 64.4850763807 1.28030099724 0.1 0.001 76.0 10.0 7.0
i 1.0 65.4682678566 0.495734350684 0.05 . 79.0 12.0 7.02
i 1.0 65.9640022073 0.69866333725 0.02 0.1 81.0 8.0 7.03
i 1.0 66.3625762219 0.802445453679 0.2 0.001 83.0 7.0 6.09
i 1.0 67.0643297234 1.01188585766 0.01 . 66.0 10.0 8.09
i 1.0 67.6701368819 1.84125988503 0.005 . 73.0 15.0 8.1
i 1.0 68.4840600883 5.2470464001 0.005 0.1 78.0 30.0 8.07
i 1.0 70.5497697462 5.35740940706 1.0 1.0 90.0 80.0 5.06
i 1.0 72.0220329025 5.43466351193 1.5 2.0 37.0 60.0 11.05
i 1.0 72.4466525868 7.71668466351 1.0 2.5 33.0 60.0 11.08
i 1.0 72.9799103598 0.536016848223 0.3 0.001 60.0 10.0 10.09
i 1.0 80.1633372503 1.49263942262 0.1 0.001 76.0 10.0 7.0
i 1.0 81.3098659764 0.577402975831 0.05 . 79.0 12.0 7.02
i 1.0 81.8872689523 0.812999412456 0.02 0.1 81.0 8.0 7.03
i 1.0 82.3511778671 0.933115253914 0.2 0.001 83.0 7.0 6.09
i 1.0 83.1672674437 1.17522310795 0.01 . 66.0 10.0 8.09
i 1.0 83.8710769524 2.13526693556 0.005 . 73.0 15.0 8.1
i 1.0 84.815669959 6.06373265157 0.005 0.1 78.0 30.0 8.07
i 1.0 87.2080541176 6.17409565853 1.0 1.0 90.0 80.0 5.06
i 1.0 88.9089894242 6.25134976339 1.5 2.0 37.0 60.0 11.05
i 1.0 89.3989440086 8.86004541557 1.0 2.5 33.0 60.0 11.08
i 1.0 90.0138704068 0.61768547337 0.3 0.001 60.0 10.0 10.09

```


# Thurs 7/20

## Today's plan

Today's goal was to do more interesting things with the audio, and fix the more
annoying problems I've had so far.

## Thurs 7/20 progress

### Fixes

I fixed the problem of balls going offscreen.
A comment from Nolen Royalty on Zulip led me to the project's "ticks per
second" setting, and searching the Godot docs led to this page:
https://docs.godotengine.org/en/stable/tutorials/physics/troubleshooting_physics_issues.html#objects-are-passing-through-each-other-at-high-speeds

Raising from 60 to 240 seems to have done the trick.

Also found this future tip:

> Modify your fast-moving object's collision shape depending on its movement
> speed. The faster the object moves, the larger the collision shape should
> extend outside of the object to ensure it can collide with thin walls more
> reliably.

### UX

I added some buttons! Can now start, restart, and add more balls.
Ugly as heck, I cargo-culted some stuff from the RPG demo, and I don't understand how to manage the layout.

### Audio

I wanted each wall to make interestingly different sounds.
Where I got to: Each wall now has its own audio bus, and I'm playing with
different effects on each. That's a start.

I also want to trigger a different sample from each wall.
But boy does fiddling with samples take a lot of time.
I'm trying to resist going down non-programming rabbit holes there.

I spent a little while attempting to load a white noise sample to loop
with the idea that i might have one wall trigger filtered white noise instead
of an interesting sample. But:
- Godot doesn't really offer enough features to build your own synth parameters,
  eg envelope is what I really want.
  - MAYBE you could if you had a pool of audio busses, and assigned one per
    note.
  - That actually might not be a bad idea... I think I saw an example like that.
- Effects are per-bus, meaning if I control filter params at runtime they'd
  apply to all sound from that wall, not just the latest hit.
- I couldn't figure out how to override the looping settings in the audio file
  itself from code. Seems like that should be possible, but it's apparently not
  something people do at runtime much. It's intended eg for background music
  that always loops.

### Non-godot stuff

I also spent some time updating my [dotfiles](https://github.com/slinkp/dotfiles)
as there were various changes I hadn't pushed, and as always when doing that, I
noticed something that could be better (platform detection).


# 7/19 How'd Godot go?

I didn't manage to trigger any sound yesterday, but I did today!

## Yesterday's progress

I managed to build a bouncing "game" with one ball (spawns at start, random
direction and location, fixed velocity).  It's up at
https://github.com/slinkp/godot-bounce-1

Some non-obvious things:
- Why is the ball slowing down over time even though friction is set to 0?
- Why does the ball fly through the walls if I set speed too high (eg 2000)?
  - The most reliable workaround I found for this was to make the walls really
    thick offscreen. This won't work for future on-screen obstacles though.

## Today's progress:

- Experiments with preventing the ball-through-walls problem, no solution yet:
  - For now I am living with it and making speed lower than I want :(
  - Tried enabling `continuous_cd` physics for the ball, sounded relevant but
    didn't help.
  - Tried clamping ball position to the viewport. This seems to get the ball
    stuck flying along the edge of the wall occasionally, which actually makes sense.

- Experiments with fixing ball momentum:
  - Setting ball damp mode to "Replace" helped. Why though?
  - Setting wall friction to 0 didn't help, it already was by default.

- Audio success:
  - Wired up signals
  - Dynamically loading sample in code so I can replace them later
    - I found some code in a youtube tutorial https://www.youtube.com/watch?v=A-926oL_8NM
      but it seems outdated: `File` is now `FileAccess` and that's not even
      relevant, there's a much easier way to get the stream in one call via
      `load(path)`. So you can literally just do something like
      `$AudioStreamPlayer.set_stream(load("res://assets/foo.wav"))`
  - I am currently doing pitch randomly in a 2-octave range.


# Tues 7/18 Godot here we go

Today's plan: after last week's "impossible things really were impossible" Thursday,
and learning enough of godot to think I might actually be able to build one of
these things, I am going to try to:

1. Stand up a game from scratch. No player inputs at all yet.
2. Randomly at start add one bouncing ball with random start position, direction, and velocity.
   (TODO: no-gravity bounce physics; may need another look at the getting
   started bounce)
   - Obvious implication: I need walls.
3. Trigger a sound on bounce.
   TODO: What parameters does godot allow controlling and how far can I get
   with what they provide?
   You can apparently do arbitrary pitch scale (presumably via trivial
   resampling), which is promising.
   For example, the [piano keys demo](https://github.com/godotengine/godot-demo-projects/blob/master/audio/midi_piano/piano_keys/piano_key.gd)

The immediate goal is to get a handle on structuring a minimal game from scratch - what
scenes do I need? And then discover how much mileage I can get out of godot's
built-in audio. And then, if it's too limited for my later goals, figure out
what my options are for alternate sound engines.


# 7/18 Blogging travails

I had hoped to hook into the Recurse internal blog feed, but have not been able
to resolve 503 errors with adding my feed to blaggregator.
I validated the feed and fixed a warning about multiple entries with same
timestamps, which seems to have been a red herring.
I think I am going to have to drop this side quest. I can of course just write
posts and manually drop them in zulip.

# 7/17 Godot progress

I finished the "Step by step" walkthrough and nearly finished the "First 2D Game"
tutorial.

I have a feeling I'm going to need to remember this to avoid much "why did my
things move" pain:

> Before we add any children to the Player node, we want to make sure we don't
> accidentally move or resize them by clicking on them. Select the node and
> click the icon to the right of the lock. Its tooltip says "Make selected
> node's children not selectable."


I plowed through most of the steps without too many blunders.
One thing that briefly tripped me up was they didn't remind me to connect any of the
timers' `timeout` signals to the Main node. I had a suspicion about this, and
confirmed it by adding logging to the signal handlers - none of them were
triggering. Also looking at the [example source
code](https://github.com/godotengine/godot-demo-projects/blob/master/2d/dodge_the_creeps/Main.tscn) 
was useful.

One of the more magical-seeming things was at the very end, wiring up the Enter key to the start
button. Not sure I understood what's happening. 
I get that I am adding a Shortcut to the Button node in the inspector.
But did naming the InputEventAction's action `start_game` correspond to the
same named thing in Project Settings -> Input Map? Is that name an identifier?
In some other parts of Godot, you can browse or autocomplete relevant identifiers
that exist.

# 7/14 More Godot learnings

I worked through more big chunks of tutorials and built some confidence that I
can get a handle on it. Started over on the "signals" tutorial that I got into
a broken state yesterday; this time it went swimmingly.
Beyond that I didn't log specific progress. At this rate maybe I'll be able to
write something from scratch Tuesday?

Short day due to travel, needed to stop at 3 to get to airport.

# 7/14 Still trying to troubleshoot blaggretator

I downloaded the repo and trying the docker-compose setup.
`brew install docker-compose` works but hilariously does not install `docker`.
Whoops, turns out that `brew install --cask docker`
was needed (note the `--cask` is important per https://stackoverflow.com/questions/44084846/cannot-connect-to-the-docker-daemon-on-macos).

To do that I also had to `brew remove docker-compose` and `brew remove
docker-completion` as it got in the way.
Should've read docs before randomly running brew commands.

That done, and more operator errors overcome, I ran into a wall, unable to get `docker-compose up` to succeed,
looks like something misconfigured re postgres.
Posted an [issue with blaggregator](https://github.com/recursecenter/blaggregator/issues/188)
I successfully nerd-sniped Andrew Joseph Turley who helped me past my initial
blunders but didn't know what was up with the db either.

Short day. Had to depart to airport at 4pm.



# 7/13 Impossible Things day reflection

Today was a very dispiriting day.
First, a meta-reflection: It would be good to have firm time/space boundaries
when attempting something impossible. Life outside Recurse unexpectedly derailed much of
my day with some pretty major stressors. So it ended up being more like "impossible half-day".

Second, I didn't even finish "Your First 2D game." That alone is probably a day given
how difficult I found it to get used to the editor / environment at all.

The Godot editor is very complex and to my mind very finicky and unintuitive.
Not entirely unlike walking up to something like Photoshop for the first time
and expecting to be productive. For example, I had a really hard time figuring
out which node properties were per-instance and which were overrides and how to
control the scope of the changes I was making.

Some useful things I did learn...

I did get to play some with bouncing objects off walls, because the
"Creating Instances" step of the "Getting Started" tutorial includes bouncing,
albeit with gravity which I didn't want.

Two options for input controls in scripts:
https://docs.godotengine.org/en/stable/getting_started/step_by_step/scripting_player_input.html

> The built-in input callbacks, mainly `_unhandled_input()`. Like _process(),
> it's a built-in virtual function that Godot calls every time the player
> presses a key. It's the tool you want to use to react to events that don't
> happen every frame, like pressing Space to jump. To learn more about input
> callbacks, see Using InputEvent.
>
> The `Input` singleton. A singleton is a globally accessible object. Godot
> provides access to several in scripts. It's the right tool to check for input
> every frame.

Playing around I figured out how to add a "reverse direction instantly" button
to the controls of the "Listening to Player Input" example:

```
	if Input.is_action_just_pressed("ui_down"):
		# Instant flip!
        # `is_action_just_pressed` instead of `is_action_pressed`, 
        # because we don't want multiple triggers if you hold down "down".
        # Also, rotation is in radians. PI radians = half a circle aka 180 degrees.
		rotation += PI
```


The "Using Signals" tutorial is either broken or I am repeatedly making basic mistakes.
I tried twice to add the Node2D scene and a button. The first time, the button showed
up, but rendering the game placed the face icon at top left corner (I had
placed it at center) and I couldn't ever see the button, assumed it was
offscreen. I tried to back up via undo, wasn't able to get it working; tried
quitting godot and using `git revert` then restarting, but maybe I didn't fully clean
up something; re-adding the Node2D and button in the editor looked right to me, but
running the game now looked like where I had left off at the end of the "Listening to Player
Input" tutorial. No button.

I forgot to initialize the git repo until I was finished with "Listening to
Player Input" and not 100% sure what state things were in when I saved, so
perhaps the repo wasn't in a good state. Seems like I may have to start from scratch.


# 7/13 Impossible Things day plan

1. Build a 2D minimal thing in Godot
   1a: Hello world: goal 1:30pm
2. start 1 ball bouncing off walls
   - fixed direction and starting automatically or randomly: goal 2pm
   - fixed speed, direction
   - click to pick a starting point? goal 3:30pm
3. Audio
   - fixed sound native in godot
   goal: 3pm
4. Figure out if can change pitches in godot?
   https://www.youtube.com/watch?v=-fyhjHbFP_8
   If not, quickly pivot to: can i somehow trigger something else? faust?
   even if just a proof of concept beep
   goal: 4pm


# 7/12 Godot

The intro docs are pretty friendly, but it's surpringly not very visible "how
do I install this thing". One answer for MacOS turned out to be simply `brew
install godot`, but I had to search the FAQ for "install" to find that.


# 7/12 running at the scary thing

As per the previous entry, I posted yesterday on zulip asking recursers for help
picking a game engine. Godot sounds like a good fit.

Am considering trying to write the _entire thing_ of "breakout pong," in
language(s) I've never used before (either Godot script or C#), for
"Impossible Things Thursday", which fortuitously is _tomorrow_.

That gives me the rest of today to work through a bit of Godot intro tutorials.

Eep.


More idea for a bouncing realtime sequencer thing:

- Each wall is a note trigger for a different sound (sampler or synth)
  - balls aren't triggers of their own sounds maybe
- Your only controls are:
  - _resizing_ or _dragging_ the window to affect bounces
  - _adding_ or _removing_ balls
    - speed can only be set when adding?

Later enhancement:
 - control to toggle _stickiness_ for a wall.
   When a wall is sticky, balls adhere to it and the sample/voice sustains or
   loops. When a sticky wall is set un-sticky, balls are immediately released
   with their old direction/velocity

# 7/11/23 Reset!

I had an epiphany that while it's fun to write little scheme functions and get
them working on (usually) the first try, that's a strong indicator that this
project of working through [The Little Schemer](https://mitpress.mit.edu/9780262560993/the-little-schemer/) is **too easy**.
Also, I could theoretically do this book any time.

It's true that I haven't made the time during the past 14 years of being a
working parent, but _that doesn't make it a good Recurse goal_.
I won't be happy if I leave here and my big accomplishment is finishing this
little book.

It really helped having an office hours meeting with Liz talking through all this. Thanks Liz.

So, I'm dropping the book. I'm not sorry I tried that - it was much fun and
helped me build confidence about FP and working the recursive thinking muscles.

Instead, I really want to have a go at my current biggest idea:

* Game-like user interface
* ... Which has as its goal producing/creating sounds/music.
* So it's a sort of virtual musical instrument,
  ... that doesn't look anything like an instrument
  ... and is more about exploring the effects of your actions than about
  precise control. I like chaotic exploratory music :)
* Side goal: Write this in a functional language or functional style, if possible.

So why haven't I started?

Partly because there's a lot of [yak
shaving](http://www.catb.org/jargon/html/Y/yak-shaving.html) involved, and I am afraid of my
apparently unbounded ability to get distracted by fuzzy yaks.

Also, as long as I haven't started, I haven't failed!

I think the thing to do is to take a run at getting a minimal prototype working as fast as possible, and iterate.

What would that look like?

- Pick a game / UI framework. Any.  (Yak shaving!)
  - Bonus points if it's functional
- Build the simplest UI I can think of (two ideas below).
- Pick a sound / synthesis engine that can be triggered/controlled from the game framework. (More yak shaving!)
  - Bonus points if it's functional.
  - Some possibilities to follow up on in a previous entry
- Wire up the UI to the engine.
- Iterate.

Simple idea 1: Breakout Percussion

- Objects bounce around a 2D space
- You control something that they can bounce off, eg the classic breakout/pong paddle
- I got some inspiration from [fellow recurser Nolan's DVD game](https://itseieio.itch.io/dvdlogo)
- Connect it to some sort of sound engine
  - initially could use in-engine synthesis assuming the engine provides enough
  - simplest idea: every impact triggers a musical sound
    - each object has "a sound"
    - parameters of that sound controlled by: relative velocity, size (mass?),
      x/y coordinates of impact.
      - possible parameters: pitch, volume, envelope ...
    - So every impact makes _two_ sounds as there's two colliding bodies

How to validate this idea as fast as possible:

- Timebox each step.
  Eg can I get _anything_ bouncing in X hours? Yes? Then stop there.
  Can I get _any_ sound triggered by a collision? Yes? Then stop there.
- Keep each step REALLY minimal.

At first this wouldn't be much different to play than a really pointless
and noisy breakout-like prototype (where nothing breaks).
How long would it take to make it interesting? _musically_ interesting?

Ideas for later iterations of pong:

- More involved game physics might make for interesting interactions.
  Eg gravity! Damage?

- "Filter areas." Drag to create a shape, any events that happen within that
  area get their sound run through a filter. Could literally be LPF, bandpass,
  etc. But also other effects. Eg: pitch shift!

- Player can add or remove bouncing objects?
- Player can pause objects?
- Build stationary obstacles?

Simple idea 2: Mixer Space / Sound Garden

- First, there are stationary objects that make continuous loops or generative
  sounds.  (How to create these is TBD; could be hard-wired initially.)

- Player controls a thing that is essentially a stereo microphone
  - The controls could affect rotation, movement, pickup pattern of microphone(s),
    maybe sensitivity (eg how far away can you hear something)

- Volume and stereo panning of each object's sound in the output is determined by
  your proximity and orientation to it

Ideas for later iterations of mixer space:

- Ways to interact with the stationary objects to change their parameters?
  - Move them
  - Make them bigger/smaller (louder/softer)
  - Add filters, change their loops

- 3D :D


# 7/10 Little Schemer continued

I got into the `*` functions in chapter 5, basically all about recursive
descent into nested lists. This builds on the previous work, not too
challenging so far.


# 7/8/23 Saturday: I basically fixed my blog

There's more to do as per the 7/6 TODO list, but at least I can update it
again. Good weekend accomplishment!
Switched to the `gum` theme and [submitted a patch to it](https://github.com/getpelican/pelican-themes/pull/752)

# 7/7/23 presentations

I presented on recursive math in Scheme, showed examples
as per [walkthrough.scm](./little_schemer/walkthrough.scm)
Not a very smooth talk but hopefully it was fun and maybe enlightening to at
least one person?

# 7/7/23 AMA with Ezzeri about job search

Notes from the meeting:
https://docs.google.com/document/d/1FPMl2IIxn_Gx_7kw9tgoTWWEcQJ9d3KZD8R5iK5rgWg/edit

This has good info in the "informational interviews" section about finding more leads:
https://haseebq.com/how-to-break-into-tech-job-hunting-and-interviews/#:~:text=informational%20interview.-,Informational%20Interviewing,-Here%E2%80%99s%20what%20you


# 7/7/23 Ideas of things to do meetings / interest groups / talks about

- Weird old software: Zope 2

- Weird old software: Csound et al

- Things I learned the hard way doing tech talks?

- Things I wish I'd known earlier about working at startups
  - equity
    - options are a high risk high reward long shot
    - options cost money
      - taxes add to that
  - Founders are chasing the money by necessity
    - chaos results
  - Founders can walk away with nothing even if the company "succeeds"
  - Acquisitions
  - Growing pains: communication
    - Flat doesn't scale
    - Project dependencies
  - Layoffs are never personal
    - Nobody can ever promise you there won't be layoffs


# 7/7 more stuff to read...

I forget who sent me this:
https://www.evalapply.org/posts/what-makes-functional-programming-systems-functional/

# 7/7/23 Game dev group

Irvin Hwang: Unity is pretty easy
Alex Chen made a game in haskell!
zarak: Godot is a good alternative to unity based on hacker news discussion?
Lightweight, runs everywhere.
Nolen: Godot's type system is "crappy", first-class functions are broken prior
to Godot 4, but Godot 4 "can't export to web"

https://gameprogrammingpatterns.com/
"To start understanding how to structure game code"

Something that struck me about feedback on Alex's demo:
"Need more affordances"
- ie feedback (visual, audio, shaking effects etc)
to show the user when they've successfully done something
(or not)

recommended book:
https://www.amazon.com/Visual-Thinking-Kaufmann-Interactive-Technologies/dp/0123708966

# 7/6 SICP meeting

Interesting perspective on the SICP book/ course:
It's aimed at first-year MIT students where they don't necessarily have
programming background but they ALL have heavy math background.

Zach R: "You can pick and choose the exercises"
- he skipped some problems - eg calculus, derivatives

They worked through some set problems... eg testing for membership,
removing duplicates, set intersection.
Much of this was VERY familiar from Little Schemer and I think I could have
solved some or all of them recursively.

Unfamiliar part: Interesting pattern of defining an inner function that's recursive,
and passing it an empty list in which to accumulate the result,
so that the outer function doesn't have to have empty list as an argument.


# 7/6 paired with Erika

This turned into Erika trying to teach me what algebraic data types are.
Abstractly kind of makes sense but head is a bit spinning trying to think of
real examples... going to read an article she sent me.

# 7/6 more "The Little Schemer"

I haven't taken much notes on this...
should mention a few things:

- I'm doing the work in the [little schemer directory in this repo](./little_schemer/)
- I started using Guile largely because it was readily available on the mac
- There are some syntax differences
  - I was initially unaware of the difference between symbols and strings,
    eg I thought `(list "foo" "bar")` was the same as `'(foo bar)`
    but ... they are not. Symbols are their own type.
  - In the book, a lot of example data is like `(lettuce and tomato)`
    which I am transliterating as either `'(lettuce and_ tomato)`
    or `(list "lettuce" "and" "tomato")` depending on mood.
    - In guile, you can't have an unquoted list of bare strings because it
      wants to treat the first element as a function to call, hence the need
      for the `(list ...)` function.
    - In guile, you can't have `'(foo and bar)` as a list of symbols, because
      `and` is a keyword, hence why I'm doing `(foo and_ bar)`

- I don't have a good way to confirm that output matches expected book output,
  other than visual inspection. It might be handy later to have something like
  a test assertion function. I bet I could find something like that or write one.
  Like `(expect_eq foo bar notes)`
  - Meanwhile I am just putting the expected output in comments.

- As a crude form of literate programming, I have a couple helpers for
  annotating the output:

  ```scheme

;; Easier than manual newlines
(define print
  (lambda (s)
    (display s)
    (newline)
    ))

(define header
  (lambda (s)
    (newline)
    (display s)
    (newline)
    (display "============================================")
    (newline)
    (newline)
    ))

  ```


- Update! I just wrote a test function to automate functions return as
  expected. Took a couple minutes and worked the first time, only needed tweaking
  for readability. That feels good! Confirmation that I can write
  beginner-level scheme, up to a point. Here it is:

```guile

(define expects_eq
  (lambda (a b note)
    (cond
     ((equal? a b) ;; WARNING, don't use `eq?` it tests identity, like python `is`.
      (display "As expected: ")
      (display note)
      (newline)
      (display a)
      (newline)
      (newline))
     (else
      (display "Failed to match expectation: ")
      (display note)
      (newline)
      (display "Expected: ")
      (display a)
      (newline)
      (display "Got: ")
      (display b)
      (newline)
      (newline)))))

(expects_eq "a" "a" "a equals a")
(expects_eq "a" "b" "a equals b")
(expects_eq '(a b c) '(a b c) "matching lats")
(expects_eq '(a b c) '() "mismatching lats")
```

# 7/5/23 More hacking on broken blog infrastucture

I was able to get a working-ish stripped down config with slightly older
dependencies on the `experimental-pelican-420-2`, with page paths the way I want.
Big changes from what's on main as of `c02a4ba6b8ff25148df6f9cd288a02bea82d08d3`:

- Some older dependency versions pinned in `requirements.txt`.  Mainly pelican 4.2.0, and
  other versions experimentally arrived at until warnings/errors went away.
- `rm -rf content/pages/photo_album` as it causes a ton of noise in output and I don't care about that old junk at this time.
- Disabled `i18n_subsites` plugin, don't need it without the bootstrap theme
- Re-enabled `page_hierarchy` plugin
- Restore the `PATH_METADATA` setting, needed to put pages in `output/` instead of `output/pages`

Having done all that, I then found that the same config basically works on pelican
4.8.0 too. So it's not a problem with package versions after all!
Currently have those changes on the `hacking_no_photo_album_on_main` branch.

TODO in rough order:

- [x] Clean up that branch and merge back to main.
- [x] Fix some remaining warnings, looks i have some path problems.
- [ ] Re-enable my `pelican-redirect` plugin hack... doesn't seem to be finding anything
- [x] Re-enable the tag cloud plugin.
- [ ] Audit pelicanconf.py for remaining things I disabled while fixing, and try to restore them all.
- [x] Find a theme I like better than default that still works on pelican 4.8.0.
- [x] Push updates
- [ ] Fix auto-linking URLs in markdown
- [ ] Start blogging again??
- [ ] Get `content/pages/photo_album` working again? Probably nobody cares including me...


# 7/5/23 people who might be resources re functional programming:

Raunak Singh
Rhea Jara
Aditya
Erika

# 7/5/23 Running list of functional programming music / sound resources

## TODO idea: one or more "hello world" in each of those

[The Haskell School of
Music](https://www.cs.yale.edu/homes/hudak/Papers/HSoM.pdf)

> This textbook explores the fundamentals of computer music using a
> language-centric approach. In particular, the functional programming lan-
> guage Haskell is used to express all of the computer music concepts. Thus a
> by-product of learning computer music concepts will be learning how to
> program in Haskell. The core musical ideas are collected into a Haskell li-
> brary called Euterpea.

- courtesy Andrew Joseph Turley

[Elementary Audio](https://www.elementary.audio/)

> Elementary is a JavaScript framework and high performance audio engine...
> Elementary brings the functional, reactive programming model to a world
> dominated by imperative, object oriented code. That means faster development,
> simpler code, and unimpaired creativity.

- courtesy Machiste Quintana

[Faust](https://faust.grame.fr/)

> Faust (Functional Audio Stream) is a functional programming language for
> sound synthesis and audio processing with a strong focus on the design of
> synthesizers, musical instruments, audio effects, etc.

- courtesy Machiste Quintana

[CLM](https://ccrma.stanford.edu/software/snd/snd/clm.html)

> CLM (originally an acronym for Common Lisp Music) is a sound synthesis
> package in the Music V family. It provides much the same functionality as
> Stk, Csound, SuperCollider, PD, CMix, cmusic, and Arctic — a collection of
> functions that create and manipulate sounds, aimed primarily at composers (in
> CLM's case anyway). The instrument builder plugs together these functions
> (called generators here), along with general programming glue to make
> computer instruments. These are then called in a note list or through some
> user interface (provided by Snd, for example).

- courtesy of myself

[Extempore](https://extemporelang.github.io/)

>  Extempore is a programming language and runtime environment designed to
>  support cyberphysical programming, where a human programmer operates as an
>  active agent in the world.
> You might have seen Extempore used for livecoding—making live music & visuals
> with code—and it's certainly very good at that, but Extempore's ambitions are
> broader :) 

- courtesy Vijith Assar

[Overtone](https://overtone.github.io/)

> Overtone is an open source audio environment designed to explore new musical
> ideas from synthesis and sampling to instrument building, live-coding and
> collaborative jamming. We combine the powerful SuperCollider audio engine,
> with Clojure, a state of-the-art lisp, to create an intoxicating interactive
> sonic experience.

- courtesy Vijith Assar

[tidal cycles](https://tidalcycles.org/)

sounds similar to Overtone?

> Tidal Cycles (or 'Tidal' for short) is a free/open source live coding
> environment for algorithmic patterns, written in Haskell. Tidal is using
> SuperCollider, another open-source software, for synthesis and I/O.

- courtesy Andrew Joseph Turley

[Pure lang](https://agraef.github.io/pure-lang/)

> Pure is a modern-style functional programming language based on term rewriting. ...
> It also integrates nicely with a number of other computing environments, most notably Faust, Pure Data, Octave, Reduce and TeXmacs.

- courtesy Sonke Hahn


# 6/29/23 pelican hacking

Trying to get my Pelican-based [website](https://slinkp.com) unbroken.
Fixed most of the errors.
But with current pelican version 4.8.0, pages now have '/pages' as part of the URL, which breaks my existing URLs.
eg `/bass` is now `/pages/bass`.
Unclear when that started.

Am now playing in a fresh instance in ~/src/pelican-hacking/
Same behavior in Pelican 4.6.0.

It seems I used to run Pelican 4.2.0, and 3.7.1 before that.
So far haven't managed to get a working installation that old with python 3, maybe look at my
old requirements.txt? Maybe need to spin up python 2.7 somewhere? :(



# 6/27/23 pairing on Mastermind

Rules:
•There are six colors
•Computer randomly chooses a secret code (4 colors, can have duplicates, in a specific order)
•Player has 10 tries to guess the secret code
•After each guess, computer "grades" the guess, as follows:
•1 black peg for each exact match (right color in the right spot)
•1 white peg for each color match (right color in the wrong spot)

https://replit.com/@slinkp/recurse-mastermind-06272023#main.py
paired with Aaron Wood https://github.com/itscomputers


# Intro meeting 6/26/23

Check out neurodiversity zulip group re ADD

Do I know Ed Younskevicius?

Follow up Cormac's thing re python/lxml

Q: in zulip - Where do I post questions that I'm not sure where to post?

RHEA: "don't beat yourself up about recognizing that you're doing too much and
dropping some stuff"

Dan: Remember the unconscious may say "I'm behind" - that's coming from you,
not from other people

Aditya: Shitcode and performance art
Checkins are good, do them / attend them as much as possible
Also feelings checking
Also morning meditations

Corin Faife: Do presentations! Good muscle to build and good for others

Pierre: Good to start a lot of projects and not worry about finishing them

Mai: Flailing alone is a waste of time - practice asking for help.
Alternative ways to do it - present about where you're stuck

Jeff Zhang: 1st 2 weeks socialize as much as possible

Sean Luo is in LIC


Functional programming:
- Aditya wants to do FP and interpreter stuff
- Erika (seattle) wants to port a parser and renderer for a markup language from typescript to elixir
- Raunuk wants to do some SCIP problems

Follow up - several people interested in Django
Moises interested in python

Erika - follow up re CLI eg bash completion

Don't be afraid to mute

Doron
- SMT solver: A theorem prover that starts from constraints you give it
Satisfiability problems
Changlin - "Hard to make a good one"
typically exponential performance
lots of tricks

