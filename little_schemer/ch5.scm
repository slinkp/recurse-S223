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


(print "page 82. Recursive insertion to right")
(define insertR*
  (lambda (new old l)
    (cond
     ((null? l) '())
     ((atom? (car l))
      (cond
       ((eq? old (car l))
        (cons old (cons new (insertR* new old (cdr l)))))
       (else
        (cons (car l) (insertR* new old (cdr l))))))
     (else
      (cons (insertR* new old (car l))
            (insertR* new old (cdr l)))))))

;; Heh, the first time I tried this, I got:
;; ((chuck chuck (chuck)) chuck ((chuck (chuck) chuck roast)) (((chuck roast))) (chuck (chuck) ((chuck chuck roast))) chuck chuck roast chuck)

(expects_eq
 (list (list 'how 'much '(wood))
       'could
       (list (list 'a '(wood) 'chuck 'roast))
       (list (list '(chuck roast)))
       (list 'if '(a) (list '(wood chuck roast)))
       'could 'chuck 'roast 'wood)
 (insertR*
  'roast 'chuck
  (list
   (list 'how 'much '(wood))
   'could
   (list (list 'a '(wood) 'chuck))
   (list (list '(chuck)))
   (list 'if '(a) (list '(wood chuck)))
   'could 'chuck 'wood))
 "It recurses into sub-lists"
 )

(header "The First Commandment, final version.  (p 83)")
(print "When recurring on a list of atoms `lat`, ask two questions: `(null? lat)` and `else`")
(print "When recurring on a number `n`, ask two questions: `(zero? n)` and `else`")
(print "When recurring on a list of S-expressions `l`, ask 3 questions:")
(print "(null? l), (atom? (car l)), and `else`.")

(newline)
(print "All lists are either: empty, an atom consed onto a list, or a list consed onto a list.")

(header "The Fourth Comandment, final version. (p 84)")
(print "Always change at least one argument while recurring.")
(print "When recurring on a list of atoms `lat`, use `(cdr lat)`.")
(print "When recurring on a number `n`, use `(sub1 n)`.")
(print "When recurring on a list of S-expressions `l`,")
(print "use `(car l)` and `(cdr l)` if neither `(null? l)` nor `(atom? (car l))` are true.\n")
(print "It must be changed to be closer to termination.")
(print "The changing arg must be tested in the termination condition:\n")
(print "When using cdr, test termination with `null?`")
(print "and when using sub1, test termination with `zero?`")


(header "occur* pp 84-85")

(define occur*
  (lambda (a l)
    (cond
     ((null? l) 0)
     ((atom? (car l))
      (cond
       ((eq? (car l) a)
        (+ 1 (occur* a (cdr l))))
       (else
        (occur* a (cdr l)))))
     (else
      (+ (occur* a (car l))
         (occur* a (cdr l)))))))


(define l
  (list
   '(banana)
   (list 'split
         (list (list (list '(banana ice)))
               (list 'cream '(banana))
               'sherbet))
   '(banana)
   '(bread)
   '(banana brandy)))

(expects_eq
 5
 (occur* 'banana l)
 "Recursive descent and counting matches"
 )


(define subst*
  (lambda (new old l)
    (cond
     ((null? l) '())
     ((atom? (car l))
      (cond
       ((eq? old (car l))
        (cons new (subst* new old (cdr l))))
       (else
        (cons (car l) (subst* new old (cdr l))))))
     (else
      (cons (subst* new old (car l))
            (subst* new old (cdr l)))))))

(define l
  (list '(banana)
        (list 'split (list (list (list '(banana ice)))
                           (list 'cream '(banana))
                           'sherbet))
        '(banana)
        '(bread)
        '(banana brandy)))

(expects_eq
 (list '(orange)
       (list 'split (list (list (list '(orange ice)))
                          (list 'cream '(orange))
                          'sherbet))
       '(orange)
       '(bread)
       '(orange brandy))

 (subst* 'orange 'banana l)
 "subst*: Recursive replacing atoms in a tree, p 85"
 )

