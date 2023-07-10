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


(header "Chapter 5. It's full of stars")

(define rember*
  (lambda (a l)
    (cond
     ((null? l) '())
     ((atom? (car l))
      (cond
       ((eq? a (car l)) (rember* a (cdr l)))
       (else
        (cons (car l) (rember* a (cdr l))))))
     (else
      (cons (rember* a (car l))
            (rember* a (cdr l)))))))

(expects_eq
 (list '(coffee) (list '(tea)) (list 'and '(hick)))
 (rember* 'cup (list '(coffee) 'cup (list '(tea) 'cup) (list 'and '(hick)) 'cup))
 "It recurses into sub-lists"
 )

(expects_eq
 (list (list '(tomato)) (list '(bean)) (list 'and (list '(flying))))
 (rember* 'sauce (list (list '(tomato sauce)) (list '(bean) 'sauce) (list 'and (list '(flying)) 'sauce)))
 "It recurses into sub-lists"
 )
