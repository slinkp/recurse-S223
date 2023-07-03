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

(header "Chapter 3. Cons the magnificent")

(header "Here's a broken version equivalent to the one on page 34, so the examples come out wrong")
(define rember
  (lambda (a lat)
    (cond
     ((null? lat) lat) ;; equivalent to ((null? lat) '())
     ((eq? a (car lat))
      (cdr lat))
     (else
      (rember a (cdr lat)))))) ;; # TODO: Add car lat to (rember (cdr lat))


(define a 'mint)
(define lat '(lamb chops mint jelly))
(print (rember a lat)) ;; want (lamb chops jelly), get (jelly)

(define lat '(lamb chops mint flavored mint jelly))
(print (rember a lat)) ;; want (lamb chops flavored mint jelly), get (flavored mint jelly)


(print (rember 'toast '(bacon lettuce tomato))) ;; want (bacon lettuce tomato), get ()

(print (rember 'cup '(coffee cup tea cup hick cup))) ;; want (coffee tea cup hick cup), get (tea cup hick cup)

(header "Left off on p 35 walking through it")
