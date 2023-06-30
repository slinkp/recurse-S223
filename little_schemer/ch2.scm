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

(header "Chapter 2.  p 15-19. Lat?")

(print "Introduces recursion as a way to check each element of a list")
(print "to see if they are all atoms")

;; We put the function from p 16 first because otherwise errors.
(define lat?
  (lambda (l)
    (cond
     ;; A list is a lat if it's null...
     ((null? l) #t)
     ;; Or if the first element is an atom, and the REST of the list is also a lat.
     ;; Woohoo recursion!
     ((atom? (car l)) (lat? (cdr l)))
     (else #f))))

(define l '(Jack Sprat could eat no chicken fat))
(print (lat? l)) ;; #t, it's a list of atoms.
(define nested (list '(Jack) "Sprat could eat no chicken fat"))
(print (lat? l)) ;; #f, first element is a list
(define nested2 (list "Jack" (list "Sprat" "could") "eat" "no" "chicken" "fat"))
(print (lat? l)) ;; #f, second element is a list
(print (lat? '())) ;; #t, it does not contain a list

(print (lat? '(bacon and eggs))) ;; #t

(define l (list "bacon" '(and eggs)))
(print "Pages 19-21. Now trying a non-lat")
(print (lat? l)) ;; #f
