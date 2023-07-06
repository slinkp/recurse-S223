#!/usr/bin/env guile -s
!#

;; Scheme function missing from Guile that is given in the prologue
;; and again on page 10
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

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

;; instead of expected output as comments, let's write an assertion function!

(define expects_eq
  (lambda (a b note)
    (cond
     ((equal? a b) ;; WARNING, don't use `eq?` it tests identity, like python `is`.
      (display "OK: ")
      (display note)
      (newline)
      (display a)
      (newline)
      (newline))
     (else
      (display "FAILED to match expectation: ")
      (display note)
      (newline)
      (display "Expected: ")
      (display a)
      (newline)
      (display "Got: ")
      (display b)
      (newline)
      (newline)))))

;; (expects_eq "a" "a" "a equals a")
;; (expects_eq "a" "b" "a equals b")
;; (expects_eq '(a b c) '(a b c) "matching lats")
;; (expects_eq '(a b c) '() "mismatching lats")


(header "Chapter 4. Numbers games!")

(expects_eq #t (atom? 14) "Numbers are atoms")

(define n 14)

(expects_eq #t (atom? n) "Numbers are atoms")

(expects_eq #t (atom? -3) "Numbers are atoms")

(print "add1 definition provided by book")
(define add1
  (lambda (n)
    (+ n 1)))

(expects_eq 68 (add1 67) "add1 works and gives a number")

(print "sub1 also provided by book")
(define sub1
  (lambda (n)
    (- n 1)))

(expects_eq 4 (sub1 5) "sub1 works")

(expects_eq -1 (sub1 0) "sub1 works with negative nubmers, although book ignores them")

(expects_eq #t (zero? 0)  "zero? tests if a number is zero, returns bool")

(expects_eq #f (zero? 9)  "zero? tests if a number is zero, returns bool")

(expects_eq #f (zero? -9)  "zero? tests if a number is zero, returns bool")

(header "pp 60-61. Addition and subtraction via recursive add1 and sub1")

(define o+
  ;; Doesn't handle negative n!
  (lambda (n m)
    (cond
     ((zero? n) m)
     (else (add1 (o+ (sub1 n) m))))))

(print "Very wild quote from page 63:")
(print "[A positive integer] is either zero")
(print "or it is one added to a rest, where rest is again [an integer]\n")

(print "p 63: (zero? n) is the termination condition on a number")
(print "p 63: (sub1 n) is the naturation recursion on a number")

(expects_eq 58 (o+ 46 12) "o+ homegrown addition via recursive increment/decrement")

(define o-
  ;; Doesn't handle negative m!
  (lambda (n m)
    (cond
     ((zero? m) n)
     (else (sub1 (o- n (sub1 m)))))))

(expects_eq 11 (o- 14 3) "o- homegrown subtraction")
(expects_eq 8 (o- 17 9) "o- homegrown subtraction")

(expects_eq -7 (o- 18 25) "subtracting n > m works too")

(header "Summing a list. Homegrown `addtup` function. pp 62-")
(print "A 'tuple' here is any list of only numbers.")

;; Got this right on the first try!
(define addtup
  (lambda (tup)
    (cond
     ((null? tup) 0) ;; Termination condition. If there are no numbers, the sum is zero
     (else
      (o+ (car tup)
          (addtup (cdr tup))))))) ;; Natural recursion.

(expects_eq 0 (addtup '()) "Sum of empty list is 0")

(expects_eq 10 (addtup (list 10)) "Sum of list (x) is x")

(expects_eq 18 (addtup (list 3 5 2 8)) "sum of list")
(expects_eq 43 (addtup (list 15 6 7 12 3)) "sum of list")

(header "The First Commandment, revised.  (p 64)")
(print "When recurring on a list of atoms ask two questions: `(null? lat)` and `else`")
(print "When recurring on a nmber, ask two questions: `(zero? n)` and `else`")

(header "Multiplication as recursive addition, pp 64-65")

;; This worked on the first try as well.
(define x
  (lambda (n m)
    (cond
     ((zero? m) 0)
     (else
      (o+ n (x n (sub1 m)))))))

(expects_eq 0 (x 5 0) "mult by zero equals zero")
(expects_eq 5 (x 5 1) "mult by one equals x")
(expects_eq 15 (x 5 3) "multiplication works")
(expects_eq 36 (x 12 3) "mult works, example from page 66")

(header "The Fifth Commandment, p 67")
(print "When building a value with `+`, always use 0 for the value of the terminating line")
(print "because adding 0 does not change the value of an addition.")
(print "When building a value with `x`, always use 1 for the value of the terminating line")
(print "because multiplying by 1 does not change the value of a multiplication.")
(print "When building a value with `cons`, always consider `()` for the value of the terminating line.")
(newline)

;; Mostly got this right on the first try.
(define tup+
  ;; Pairwise addition.
  ;; Adds the first number of tup1 to the first of tup2,
  ;; then the second number of tup1 to the second of tup2, etc.
  ;; and returns the results as a tuple.
  (lambda (tup1 tup2)
    (cond
     ;; Assume the tuples are equal length.
     ;; This was my only difference from the book version on 69:
     ;; I only checked tup1 and assumed tup2 was null too.
     ((and (null? tup1) (null? tup2)) '())
     (else
      (cons
       (o+ (car tup1) (car tup2)) ;; first element
       (tup+ (cdr tup1) (cdr tup2)) ;; natural recursion
       )))))

(expects_eq
 (list 11 11 11 11 11)
 (tup+ (list 3 6 9 11 4) (list 8 5 2 0 7))
 "pairwise addition")

(expects_eq
 (list 6 9)
 (tup+ (list 2 3) (list 4 6))
 "pairwise addition"
 )

;; Here's an improved version that returns remaining elements unchanged if
;; one tuple is shorter.
;; I did not think of this on my own,
;; I got stuck on "How do I build a list of zeros of the right size" :facepalm:

(define tup+
  (lambda (tup1 tup2)
    (cond
     ((null? tup1) tup2)
     ((null? tup2) tup1)
     (else
      (cons
       (o+ (car tup1) (car tup2)) ;; 1st element
       (tup+ (cdr tup1) (cdr tup2)) ;; natural recursion
       )))))

(expects_eq
 (list 7 13 8 1)
 (tup+ (list 3 7) (list 4 6 8 1))
 "Pairwise addition of unequal length tuples"
 )

(expects_eq
 (list 7 13 8 1)
 (tup+ (list 3 7 8 1) (list 4 6))
 "Pairwise addition of unequal length tuples"
 )

(header "Recursive > implementation, page 71")

;; I got this working on first try :)
;; This is similar to version on p 73.
(define gt  ;; Could do > but don't want to override builtin
  (lambda (n m)
    (cond
     ;; The book deliberately made a broken version on page 72 where next lines are swapped
     ((zero? n) #f)  ;; Assuming non-negative numbers
     ((zero? m) #t)  ;; Only get here if n > 0
     (else
      (gt (sub1 n) (sub1 m))))))

(expects_eq #f (gt 12 133) "Simple > implementation")

(expects_eq #t (gt 120 11) "Simple > implementation")

(expects_eq #f (gt 5 5) "Not > when equal")

(expects_eq #f (gt 0 0) "Not > when equal")

(header "Recursive < or lt implementation, pp 72-73")

;; This worked on first try!
(define lt
  (lambda (n m)
    (cond
     ((and (zero? n) (zero? m)) #f)
     ((zero? n) #t)
     ((zero? m) #f)
     (else
      (lt (sub1 n) (sub1 m))))))

;; Simpler book version from page 73
(define lt
  (lambda (n m)
    (cond
     ((zero? m) #f) ;; We've assumed non-negative, so n is zero or bigger, either way false!
     ((zero? n) #t) ;; We know from above that m is not 0, so this suffices!
     (else
      (lt (sub1 n) (sub1 m))))))

(expects_eq #t (lt 12 133) "Simple < works")
(expects_eq #t (lt 0 1) "yep")

(expects_eq #f (lt 0 0) "False for zero")
(expects_eq #f (lt 3 3) "False when equal")
(expects_eq #f (lt 33 3) "False when bigger")


(header "Recursive equality from page 74")

;; Worked on first try.
(define ==
  (lambda (n m)
    (cond
     ((and (zero? m) (zero? n)) #t)
     ((zero? m) #f)
     ((zero? n) #f)
     (else
      (== (sub1 n) (sub1 m))))))

;; Simpler, book version from p 74
(define ==
  (lambda (n m)
    (cond
     ((zero? m) (zero? n))
     ((zero? n) #f)
     (else
      (== (sub1 n) (sub1 m))))))

;; Rewritten using gt and lt
(define ==
  (lambda (n m)
    (cond
     ((lt n m) #f)
     ((gt n m) #f)
     (else #t)))) ;; Recursion not needed here, already done it

(expects_eq #t (== 0 0) "zero == zero")
(expects_eq #f (== 5 0) "non-equal")
(expects_eq #f (== 0 3) "non-equal")
(expects_eq #t (== 5 5) "nonzero equal")
(expects_eq #f (== 5 7) "non-equal")
(expects_eq #f (== 7 5) "non-equal")

(header "Recursive exponents yay")

;; Got this right on first try, though i had to check expected value of (^ 0 0)
(define ^
  (lambda (n m)
    (cond
     ((zero? m) 1) ;; termination
     (else
      (x n (^ n (sub1 m))))))) ;; natural recursion

(expects_eq 1 (^ 1 1) "1 to the 1th is 1")
(expects_eq 1 (^ 1 1000) "1 to the anything is 1")
(expects_eq 1 (^ 1 0) "1 to the 0th is 1")
(expects_eq 1 (^ 0 0) "0 to the 0th is ... also 1")
(expects_eq 0 (^ 0 2) "0 to the 2 is 0")
(expects_eq 2 (^ 2 1) "2 to 1 is 2")
(expects_eq 65536 (^ 2 16) "2 to 16th is 65536 .. slowly")

(print "\nPause for a moment to consider we built exponents recursively on multiplication...")
(print "... built recursively on top of addition...")
(print "... recursively on top of increment and decrement...")
(print "... that's a lot of decrements")

(header "Naming the mystery function, p 74")

;; Holy crap it's integer division
;; It literally counts how many times can you subtract m from n
(define divide
  (lambda (n m)
    (cond
     ((lt n m) 0) ;; Weird termination
     (else
      (add1 (divide (o- n m) m))))))

(expects_eq 1 (divide 3 3) "omg division")

(expects_eq 6 (divide 6 1) "omg division")
(expects_eq 3 (divide 6 2) "omg division")
(expects_eq 2 (divide 6 3) "omg division")
(expects_eq 1 (divide 6 4) "omg division")
(expects_eq 1 (divide 6 5) "omg division")
(expects_eq 1 (divide 6 6) "omg division")
(expects_eq 0 (divide 6 7) "omg division")

(expects_eq 3 (divide 15 4) "yay")

(header "Length of a list is easy, just increment with recursive cdr. p 76")

(define len
  (lambda (lat)
    (cond
     ((null? lat) 0)
     (else
      (add1 (len (cdr lat)))))))

(expects_eq 6 (len '(hotdogs with mustard sauerkraut and_ pickles)) "Counting elements of list")

(expects_eq 5 (len '(ham and_ cheese on rye)) "yep still works")
(expects_eq 0 (len '()) "null list")

(header "pick nth element from list, 1-indexed. p 76")

;; This was a bit tricky and fiddly due to 1-indexing
(define pick
  (lambda (n lat)
    (cond
     ((null? lat) '()) ;; This is weird way of representing not found but ok
     ((lt n 1) '()) ;; Also weird way of terminating
     ((== n 1) (car lat))
     (else
      (pick (sub1 n) (cdr lat))))))

;; here's book version.
;; Similar but they just assume n > 0
;; and they don't allow null list.
(define pick
  (lambda (n lat)
    (cond
     ((zero? (sub1 n)) (car lat))
     (else
      (pick (sub1 n) (cdr lat))))))

(expects_eq
 'macaroni
 (pick 4 '(lasagna spaghetti ravioli macaroni meatball))
 "pick 4th element from list")

(header "remove nth element, 1-indexed. p 76")

(define rempick
  (lambda (n lat)
    (cond
     ((null? lat) '()) ;; Forgot this, needed if n passed 0
     ;; Book version also forgot to check for null!
     ((zero? (sub1 n)) (cdr lat))
     (else
      (cons
       (car lat)
       (rempick (sub1 n) (cdr lat)))))))

(expects_eq
 '(hotdogs with mustard)
 (rempick 3 '(hotdogs with hot mustard))
 "Can remove nth element with rempick")

(expects_eq
 '(hotdogs with hot mustard)
 (rempick 0 '(hotdogs with hot mustard))
 "0 means remove nothing")

(header "What are numbers?")

(expects_eq #f (number? "tomato") "strings aren't numbers")
(expects_eq #f (number? 'tomato) "symbols aren't numbers")
(expects_eq #t (number? '123) "... unless they're numeric symbols")
(expects_eq #t (number? 76) "numbers are numbers")
(print "Can't define number? it's built-in primitive function")

(header "No-nums (p 77) removes all numbers from a lat; all-nums extracts only numbers.")

(define no-nums
  (lambda (lat)
    (cond
     ((null? lat) '())
     ((number? (car lat)) (no-nums (cdr lat)))
     (else
      (cons (car lat) (no-nums (cdr lat)))))))

(expects_eq
 '(pears prunes dates)
 (no-nums '(5 pears 6 prunes 9 dates))
 "Yep no-nums works")


(define all-nums
  (lambda (lat)
    (cond
     ((null? lat) '())
     ((number? (car lat))
      (cons (car lat) (all-nums (cdr lat))))
     (else
      (all-nums (cdr lat))))))

(expects_eq
 '(5 6 9)
 (all-nums '(5 pears 6 prunes 9 dates))
 "Yep all-nums works")

(header "eqan? is true if a1 and a2 are same atom")

(define eqan?
  (lambda (a1 a2)
    (cond
     ((and (number? a1) (number? a2))
      (== a1 a2))
     ((or (number? a1) (number? a2)) #f)
     (else
      (eq? a1 a2)))))

(expects_eq #t (eqan? 11 11) "eqan? works for numbers")
(expects_eq #f (eqan? 11 33) "eqan? works for numbers")
(expects_eq #t (eqan? 'hello 'hello) "eqan? works for symbols")
(expects_eq #f (eqan? 'hello 'goodbye) "eqan? works for symbols")
(expects_eq #t (eqan? "hello" "hello") "eqan? works for strings")
(expects_eq #f (eqan? "hello" "goodbye") "eqan? works for strings")
(expects_eq #f (eqan? "hello" 'hello) "eqan? works for mixed cases")

(header "occur? counts number of times atom appears in list. p 78")

;; We've done thigns like this before
(define occur
  (lambda (a lat)
    (cond
     ((null? lat) 0)
     ((eqan? a (car lat))
      (add1 (occur a (cdr lat))))
     (else (occur a (cdr lat))))))

(expects_eq 0 (occur 'foo '(bar bat)) "none")
(expects_eq 0 (occur 'foo '()) "none")
(expects_eq 4 (occur 'foo '(foo bar bat foo baz foo foo)) "yep")

(header "one? is true if n is 1 and false otherwise, p 79")

;; there are various versions in book but i like this one
(define one?
  (lambda (n)
    (cond
     ((number? n) (zero? (sub1 n)))
     (else #f))))

(expects_eq #t (one? 1) "one? works")
(expects_eq #f (one? 0) "one? works")
(expects_eq #f (one? 100) "one? works")
(expects_eq #f (one? "1") "one? works")
(expects_eq #f (one? '()) "one? works")

(header "Rewriting rempick to use one?, p 79")

(define rempick
  (lambda (n lat)
    (cond
     ((null? lat) '()) ;; Forgot this, needed if n passed 0
     ;; Book version also forgot to check for null!
     ((one? n) (cdr lat))
     (else
      (cons
       (car lat)
       (rempick (sub1 n) (cdr lat)))))))

(expects_eq
 '(hotdogs with mustard)
 (rempick 3 '(hotdogs with hot mustard))
 "Can remove nth element with rempick")

(expects_eq
 '(hotdogs with hot mustard)
 (rempick 0 '(hotdogs with hot mustard))
 "0 means remove nothing")
