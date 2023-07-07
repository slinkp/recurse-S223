#!/usr/bin/env guile -s
!#

;; This was for a 5-min friday presentation given on 7/7/2023

;; add1 definition provided by book
(define add1
  (lambda (n)
    (+ n 1)))

;; Similar to this python code:
;;
;; def add1(n):
;;     return n + 1

;; sub1 also provided by book"
(define sub1
  (lambda (n)
    (- n 1)))

;; zero? function already in scheme

;; What does this do?
(define foo
  (lambda (n m)   ;; Assuming n is not negative
    (cond
     ((zero? n) m)
     (else (add1 (foo (sub1 n) m))))))

;; Let's walk through (foo 2 3)

;; n = 2, m = 3

;; Is n zero?
;;
;; No, so return  1 more than (foo 1 3)


;; Now we have n = 1, m = 3

;; Is n zero?

;; No, so return 1 more than (foo 0 3)

;; Is n zero?
;; So what do we return?

;;
;; -> 3

;; then walking back up...

;; -> 1 + 3 -> 4
;;
;; -> 1 + 4 -> 5
;;
;; or think of it as 1 + (1 + (3))

;; Important: termination condition, prevents infinite recursion.
;; In this case, (zero? n)

;; Important: always change the arguments when recursing
;; to get closer to the termination condition.
;; In this cases, (sub1 n)
