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
    (newline)))

(define header
  (lambda (s)
    (newline)
    (display s)
    (newline)
    (display "============================================")
    (newline)
    (newline)
    ))

(header "page 3. Atoms and lists.")

(print "Hello, world")

(define myatom 42)
(print myatom)

;; This doesn't work in guile
;; (define another *abc$)
;; (print another)
;; 

(print "Here come some atoms")

(print (atom? "yep"))

(print (atom? 1))

(print (atom? 'foo))

(print "Here come some non-atoms")

;; In guile, a list literal needs the single quote
;; or else it tries to call first arg as a function ??
(print (atom? '(1 2 3)))

;; Here's another way
(print (atom? (list 1 2 3)))

(print (atom? '()))


(header "Page 5. Some lists!")

(print (list? '()))

(print (list? '(1)))

(print (list? '(1 "hello" "whatever")))


(print "Atoms are not lists")

(print (list? "hello"))


(print "One single quote, multiple strings")

(print (list? '(hello world etc)))

(print "Nested lists")

;; So far best way I have found to do this is via the "list" constructor.
;; Can't nest like ('('('... or it actually creates a string instead of a nested list.
(print (list? (list (list (list 'how) 'are) (list '(you) '(doing so)) 'far 'today)))

(header "Pages 5-6. Car time")

(print (car '(a b c))) ;; a 

;; (print (car '()))  ;; causes error, can't car empty list

(define nesty (list (list (list 'hotdogs)) (list 'and) (list 'pickle) 'relish))
(print nesty) ;; (((hotdogs)) (and) (pickle) relish)
(print (car nesty)) ;; ((hotdogs))
(print (car (car nesty))) ;; (hotdogs)
(print (car (car (car nesty)))) ;; hotdogs


(header "The Law of Cdr, pages 5-6")

(print (cdr '(a b c))) ;; (b c)

(print (cdr nesty)) ;; ((and) (pickle) relish)
(print (cdr '(hamburger))) ;; ()

(define l  (list '(b) '(x y) (list '(c))))
(print (car (cdr l))) ;; (x y)
(print (cdr (cdr l))) ;; (((c)))
(define l (list "a" '(b c d)))
;; (print (cdr (car l))) ;; error, can't (cdr "a")

(header "Cons, pages 7-9")

(print (cons "peanut" '(butter and jelly))) ;; (peanut butter and jelly)
(define s '(banana and))
(define l '(peanut butter and jelly))
(print (cons s l)) ;; ((banana and) peanut butter and jelly)
(define s (list '(help) "this"))
(define l (list "is" "very" (list '(hard) "to" "learn")))
(print (cons s l)) ;; (((help) this) is very ((hard) to learn))

(define s (list "a" "b" '(c)))
(define l '())
(print (cons s l)) ;; ((a b (c)))

(define s "a")
(define l '())
(print (cons s l)) ;; (a)

(define s '(a b c))
(define l "b")
(print (cons s l)) ;; Supposed to be error, can't cons onto a non-list.
;; But in practice, prints ((a b c) . b)  ... don't know what that means in guile?

(define s "a")
(define l (list '(b) "c" "d"))
(print (cons s (car l))) ;; (a b)
(print (cons s (cdr l))) ;; (a c d)

(header "Null, p. 9-10")

(print (null? '())) ;; #t
(print (null? (quote ()))) ;; #t

(print "Non-empty lists aren't null")
(print (null? '(a b c))) ;; #f
(print "Atoms aren't null")
(print (null? "a")) ;; #f.  "No answer", but in practice, `null?` is false for everything but empty list
(print (null? "")) ;; #f
(print (null? 2)) ;; #f
