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