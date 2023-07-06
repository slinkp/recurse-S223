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

(header "pp 60-61. writing addition and subtraction via add1 and sub1")

(define o+
  ;; Doesn't handle negative n!
  (lambda (n m)
    (cond
     ((zero? n) m)
     (else (add1 (o+ (sub1 n) m))))))

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
