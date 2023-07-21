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
Bumping up `ticks per second` seems to fix the missing collisions. Yay!

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

# 7/11 Reset!

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


# 7/8 I basically fixed my blog

There's more to do as per the 7/6 TODO list, but at least I can update it
again. Good weekend accomplishment!
Switched to the `gum` theme and [submitted a patch to it](https://github.com/getpelican/pelican-themes/pull/752)

# 7/7 presentations

I presented on recursive math in Scheme, showed examples
as per [walkthrough.scm](./little_schemer/walkthrough.scm)
Not a very smooth talk but hopefully it was fun and maybe enlightening to at
least one person?

# 7/7 AMA with Ezzeri about job search

Notes from the meeting:
https://docs.google.com/document/d/1FPMl2IIxn_Gx_7kw9tgoTWWEcQJ9d3KZD8R5iK5rgWg/edit

This has good info in the "informational interviews" section about finding more leads:
https://haseebq.com/how-to-break-into-tech-job-hunting-and-interviews/#:~:text=informational%20interview.-,Informational%20Interviewing,-Here%E2%80%99s%20what%20you


# 7/7 Ideas of things to do meetings / interest groups / talks about

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

# 7/7 Game dev group

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

# 7/5 More hacking on broken blog infrastucture

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


# 7/5 people who might be resources re functional programming:

Raunak Singh
Rhea Jara
Aditya
Erika

# 7/5 Running list of functional programming music / sound resources

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


# 6/29 pelican hacking

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



# 6/27 pairing on Mastermind

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

