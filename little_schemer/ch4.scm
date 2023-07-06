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
