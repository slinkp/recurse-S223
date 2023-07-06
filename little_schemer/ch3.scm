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

;; 12/6 revisiting this chapter - instead of expected output as comments, let's write an assertion function!

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

;; (print (rember a lat))
(expects_eq
 '(lamb chops jelly)
 (rember a lat)
 "Broken rember removes everything to the left of `a`")

(define lat '(lamb chops mint flavored mint jelly))
;; (print (rember a lat)) ;; want (lamb chops flavored mint jelly), get (flavored mint jelly)
(expects_eq
 '(flavored mint jelly)
 (rember a lat)
  "Broken rember removes everything to the left of `a`")

;; (print (rember 'toast '(bacon lettuce tomato))) ;; want (bacon lettuce tomato), get ()
(expects_eq
 '(bacon lettuce tomato)
 (rember 'toast '(bacon lettuce tomato))
  "Broken rember removes everything to the left of `a`, so if a isn't found, result is empty")

;; (print (rember 'cup '(coffee cup tea cup hick cup))) ;; want (coffee tea cup hick cup), get (tea cup hick cup)
(expects_eq
 '(coffee tea cup hick cup)
 (rember 'cup '(coffee cup tea cup hick cup))
 "Broken rember"
 )

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
(expects_eq
 '(lamb chops jelly)
 (rember a lat)
 "")


(define lat '(lamb chops mint flavored mint jelly))
(expects_eq
 '(lamb chops flavored mint jelly)
 (rember a lat)
 "")


(expects_eq
 '(bacon lettuce tomato)
 (rember 'toast '(bacon lettuce tomato))
 "")


(expects_eq
 '(coffee tea cup hick cup)
 (rember 'cup '(coffee cup tea cup hick cup))
 "")


(expects_eq
 '(soy tomato sauce)
 (rember 'sauce '(soy sauce tomato sauce))
 "")


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

(expects_eq
 '(apple plum grape bean)
 (firsts lol)
 "")


(expects_eq
 '(a c e)
 (firsts (list '(a b) '(c d) '(e f)))
 "(firsts (list of lists)) works as expected")


(expects_eq
 '()
 (firsts '())
 "firsts of empty list is empty list")


(define lol
  (list
   (list '(five plums) 'four)
   '(eleven green oranges)
   (list '(no) 'more)))

(expects_eq
 (list '(five plums) 'eleven '(no))
 (firsts lol)
 "works with nested lists")


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

(expects_eq
 '(ice cream with fudge topping for dessert)
 (insertR new old lat)
 "insertR basic example")


(define lat '(tacos tamales and_ salsa))

(expects_eq
 '(tacos tamales and_ jalapeno salsa)
 (insertR 'jalapeno 'and_ lat)
 "insertR basic examples")


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

(expects_eq
 '(a b c d e f g d h)
 (insertR 'e 'd '(a b c d f g d h))
 "example with multiple occurrences of `old`, should only insert once")


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

(expects_eq
 '(a b c d e f d g)
 (insertL 'c 'd '(a b d e f d g))
 "")


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

(expects_eq
 '(a b c X y z x y z)
 (subst 'X 'x '(a b c x y z x y z))
 "basic subst example, only replaces once")


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

(expects_eq
 '(vanilla ice cream with chocolate topping)
 (subst2 'vanilla 'chocolate 'banana '(banana ice cream with chocolate topping))
 "subst2 replaces either of 2 things")


(expects_eq
 '(orange ice cream with vanilla topping)
 (subst2 'vanilla 'chocolate 'banana '(orange ice cream with chocolate topping))
 "subst2 again")


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

(expects_eq
 '(coffee tea and_ hick)
 (multirember 'cup '(coffee cup tea cup and_ hick cup))
 "remove all occurences from lat")


(header "multiinsertR, p 56")

;; this was actually my first attempt at insertR

(define multiinsertR
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     ((eq? old (car lat))
      (cons old
            (cons new (multiinsertR new old (cdr lat)))))
     (else
      (cons (car lat)
            (multiinsertR new old (cdr lat)))))))

(expects_eq
 '(a b c d e f g d e h)
 (multiinsertR 'e 'd '(a b c d f g d h))
 "multiinsertR works")


(print "fixing the book version of multiinsertL...")
(define multiinsertL
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     (else
      (cond
       ((eq? (car lat) old)
        (cons new
              (cons old
                    ;; (multiinsertL new old lat)))) ;; THIS was the broken line - infinite recursion
                    (multiinsertL new old (cdr lat)))))
       (else (cons (car lat)
                   (multiinsertL new old (cdr lat)))))))))

(expects_eq
 '(a b c d e f c d g)
 (multiinsertL 'c 'd '(a b d e f d g))
 "multiinsertL works")


(header "4th commandment (preliminary): Always change at least 1 arg when recurring.")
(print "It must be changed to be closer to termination.")
(print "The changing arg must be tested in the termination condition.")
(print "When using cdr, test termination with `null?`")

(define multisubst
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     ((eq? old (car lat))
      (cons new (multisubst new old (cdr lat))))
     (else
      (cons (car lat)
            (multisubst new old (cdr lat)))))))

(expects_eq
 '(8 great big cat took 8 flying leap on 8 car)
 (multisubst '8 'a '(a great big cat took a flying leap on a car))
 "multisubst example a -> 8")
 
