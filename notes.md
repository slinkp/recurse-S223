# 7/5 Running list of functional programming music / sound resources

[The Haskell School of
Music](https://www.cs.yale.edu/homes/hudak/Papers/HSoM.pdf)

> This textbook explores the fundamentals of computer music using a
> language-centric approach. In particular, the functional programming lan-
> guage Haskell is used to express all of the computer music concepts. Thus a
> by-product of learning computer music concepts will be learning how to
> program in Haskell. The core musical ideas are collected into a Haskell li-
> brary called Euterpea.

[Elementary Audio](https://www.elementary.audio/)

> Elementary is a JavaScript framework and high performance audio engine...
> Elementary brings the functional, reactive programming model to a world
> dominated by imperative, object oriented code. That means faster development,
> simpler code, and unimpaired creativity.

[Faust](https://faust.grame.fr/)

> Faust (Functional Audio Stream) is a functional programming language for
> sound synthesis and audio processing with a strong focus on the design of
> synthesizers, musical instruments, audio effects, etc.


[CLM](https://ccrma.stanford.edu/software/snd/snd/clm.html)

> CLM (originally an acronym for Common Lisp Music) is a sound synthesis
> package in the Music V family. It provides much the same functionality as
> Stk, Csound, SuperCollider, PD, CMix, cmusic, and Arctic — a collection of
> functions that create and manipulate sounds, aimed primarily at composers (in
> CLM's case anyway). The instrument builder plugs together these functions
> (called generators here), along with general programming glue to make
> computer instruments. These are then called in a note list or through some
> user interface (provided by Snd, for example).

[Extempore](https://extemporelang.github.io/)

>  Extempore is a programming language and runtime environment designed to
>  support cyberphysical programming, where a human programmer operates as an
>  active agent in the world.
> You might have seen Extempore used for livecoding—making live music & visuals
> with code—and it's certainly very good at that, but Extempore's ambitions are
> broader :) 

[Overtone](https://overtone.github.io/)

> Overtone is an open source audio environment designed to explore new musical
> ideas from synthesis and sampling to instrument building, live-coding and
> collaborative jamming. We combine the powerful SuperCollider audio engine,
> with Clojure, a state of-the-art lisp, to create an intoxicating interactive
> sonic experience.

TODO: one or more "hello world" in each



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

