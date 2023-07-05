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
      ;; # Wrong: This just gives us whatever's to the right of the first occurrence of `a`
      (rember a (cdr lat))))))

(define a 'mint)
(define lat '(lamb chops mint jelly))
(print (rember a lat)) ;; want (lamb chops jelly), get (jelly)

(define lat '(lamb chops mint flavored mint jelly))
(print (rember a lat)) ;; want (lamb chops flavored mint jelly), get (flavored mint jelly)


(print (rember 'toast '(bacon lettuce tomato))) ;; want (bacon lettuce tomato), get ()

(print (rember 'cup '(coffee cup tea cup hick cup))) ;; want (coffee tea cup hick cup), get (tea cup hick cup)

(header "2nd commandment, pp 37-42: Use Cons to build lists")
(print "Here is an improved `rember?`, wrote it based on knowing what cons does")
(print "it's the same as the 'simpler' version they show on p 41")

(define rember
  (lambda (a lat)
    (cond
     ((null? lat) lat) ;; equivalent to ((null? lat) '())
     ((eq? a (car lat))
      (cdr lat))
     (else
      (cons (car lat)
            (rember a (cdr lat))))))) ;; This adds (car lat) to the front of (rember a (cdr lat))

(define a 'mint)
(define lat '(lamb chops mint jelly))
(print (rember a lat)) ;; (lamb chops jelly)

(define lat '(lamb chops mint flavored mint jelly))
(print (rember a lat)) ;; (lamb chops flavored mint jelly)

(print (rember 'toast '(bacon lettuce tomato))) ;; (bacon lettuce tomato)

(print (rember 'cup '(coffee cup tea cup hick cup))) ;; (coffee tea cup hick cup)

(print (rember 'sauce '(soy sauce tomato sauce))) ;; (soy tomato sauce)

(header "`firsts` example p 43-47")
(define firsts
  (lambda (lol)
    (cond
     ((null? lol) '())
     (else
      (cons (car (car lol))
            (firsts (cdr lol)))))))

(define lol (list
             '(apple peach pumpkin)
             '(plum pear cherry)
             '(grape raisin pea)
             '(bean carrot eggplant)))

(print (firsts lol)) ;; (apple plum grape bean)
(print (firsts
        (list '(a b)
              '(c d)
              '(e f)))) ;; (a c e)
(print (firsts '())) ;; ()

(define lol
  (list
   (list '(five plums) 'four)
   '(eleven green oranges)
   (list '(no) 'more)))
(print (firsts lol)) ;; ((five plums) eleven (no))

(header "Third commandment (p 45): Cons the first typical element onto the natural recursion")

(header "insertR pp 47-50: Inserting an element to right of _first occurrence_ of another element in a list")

;; OMG, I got this (almost) right on the first try.
(define insertR
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     ((eq? old (car lat))
      (cons (car lat)
            (cons new (insertR new old (cdr lat)))))
     (else
      (cons (car lat)
            (insertR new old (cdr lat)))))))

(define new 'topping)
(define old 'fudge)
(define lat '(ice cream with fudge for dessert))

(print (insertR new old lat)) ;; (ice cream with fudge topping for dessert)

(define lat '(tacos tamales and_ salsa))
(print (insertR 'jalapeno 'and_ lat)) ;; (tacos tamales and_ jalapeno salsa)

;; ... whoops, i'm inserting it after every occurrence.
;; Oh... easy fix, just don't recur when it's found:

(define insertR
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     ((eq? old (car lat))
      (cons (car lat)
            (cons new (cdr lat))))
     (else
      (cons (car lat)
            (insertR new old (cdr lat)))))))

(print (insertR 'e 'd '(a b c d f g d h))) ;; (a b c d e f g d h)

(header "insertL on page 51")

(define insertL
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     ((eq? old (car lat))
      (cons new (cons old (cdr lat))))
      ;; Equivalent and simpler on p 51: (cons new lat) since old is already there
     (else
      (cons (car lat)
            (insertL new old (cdr lat)))))))

(print (insertL 'c 'd '(a b d e f d g))) ;; (a b c d e f d g)

(header "subst on p 51")
(define subst
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     ((eq? old (car lat))
      (cons new (cdr lat)))
     (else
      (cons (car lat)
            (subst new old (cdr lat)))))))

(print (subst 'X 'x '(a b c x y z x y z))) ;; (a b c X y z x y z)

(header "subst2 on p 52")
(print "replaces either the first occurrence of o1 or o2 by new in lat")

(define subst2
  (lambda (new o1 o2 lat)
    (cond
     ((null? lat) '())
     ((or
       (eq? o1 (car lat))
       (eq? o2 (car lat)))
      (cons new (cdr lat)))
     (else
      (cons (car lat)
            (subst2 new o1 o2 (cdr lat)))))))

(print (subst2 'vanilla 'chocolate 'banana '(banana ice cream with chocolate topping)))
;; (vanilla ice cream with chocolate topping)
(print (subst2 'vanilla 'chocolate 'banana '(orange ice cream with chocolate topping)))
;; (orange ice cream with vanilla topping)

(header "multirember on pp 53-56")
(print "Gives the lat with all occurrences removed")

;; Yay got this right on the first try
(define multirember
  (lambda (a lat)
    (cond
     ((null? lat) '())
     ((eq? a (car lat))
      (multirember a (cdr lat)))
     (else
      (cons (car lat) (multirember a (cdr lat)))))))

(print (multirember 'cup '(coffee cup tea cup and_ hick cup))) ;; (coffee tea and_ hick)
