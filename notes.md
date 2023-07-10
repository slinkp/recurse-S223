# 7/10 Little Schemer continued



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

