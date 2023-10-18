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

(define woodchucks
  (list
   (list 'how 'much '(wood))
   'could
   (list (list 'a '(wood) 'chuck))
   (list (list '(chuck)))
   (list 'if '(a) (list '(wood chuck)))
   'could 'chuck 'wood))

(expects_eq
 (list (list 'how 'much '(wood))
       'could
       (list (list 'a '(wood) 'chuck 'roast))
       (list (list '(chuck roast)))
       (list 'if '(a) (list '(wood chuck roast)))
       'could 'chuck 'roast 'wood)
 (insertR* 'roast 'chuck woodchucks)
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

(define insertL*
  (lambda (new old l)
    (cond
     ((null? l) '())
     ((atom? (car l))
      (cond
       ((eq? old (car l))
        ;; Trap: It might look like you can equivalently do (cons new (insertL* new old l))
        ;; because (cons old (cdr l)) is the same as `l`.
        ;; But no - it's crucial to not recursively call insertL* on a list that included `car l` again
        ;; or you'll just prepend forever.
        (cons new (cons old (insertL* new old (cdr l)))))
       (else
        (cons (car l) (insertL* new old (cdr l))))))
     (else
      (cons (insertL* new old (car l))
            (insertL* new old (cdr l)))))))

(expects_eq
  (list
   (list 'how 'much '(wood))
   'could
   (list (list 'a '(wood) 'pecker 'chuck))
   (list (list '(pecker chuck)))
   (list 'if '(a) (list '(wood pecker chuck)))
   'could 'pecker 'chuck 'wood)

  (insertL* 'pecker 'chuck woodchucks)
  "Recursive insertL too"
  )

(header "recursive member* for finding atom anywhere in list, p 86-87")

(define member*
  (lambda (a l)
    (cond
     ((null? l) #f)
     ((atom? (car l))
      (cond
       ((eq? a (car l)) #t)
       (else
        (member* a (cdr l)))))
     (else
      (or
       (member* a (car l))
       (member* a (cdr l)))))))

(expects_eq
 #t
 (member* 'chips (list '(potato) (list 'chips (list '(with) 'fish) '(chips))))
 "recursive membership works"
 )

(header "leftmost, p 87-88")

(define leftmost
  (lambda (l)
    (cond
     ((null? l) '())
     ((atom? (car l))
      (car l))
     (else
      (leftmost (car l))))))

(expects_eq
 'potato
 (leftmost (list '(potato) (list 'chips (list '(with) 'fish) '(chips))))
 "left item of possibly nested lists")

(expects_eq
 'hot
 (leftmost (list (list '(hot) (list 'tuna '(and_))) 'cheese))
 "left item of possibly nested lists")

(expects_eq
 '()
 (leftmost '())
 "Null gives null"
 )

(expects_eq
 '()
 (leftmost (list '()))
 "Null gives null"
 )

(expects_eq
 '()
 (leftmost (list (list (list '() 'four)) 17 '(seventeen)))
 "Nothing when empty list found"
 )


(header "eqlist?, p 89-")

;; eqlist first attempt
(define eqlist?
  (lambda (l1 l2)
    (cond
     ((and (null? l1) (null? l2)) #t)
     ((or (null? l1) (null? l2)) #f)
     ((and (atom? l1) (atom? l2)) (equal? l1 l2))
     ((or (atom? l1) (atom? l2)) #f)
     ((and (eqlist? (car l1) (car l2)) (eqlist? (cdr l1) (cdr l2))))
     (else #f)
     )))

;; eqlist rewritten slightly to use eqan? from ch 4, book suggests this.
(define eqan?
  (lambda (a1 a2)
    (cond
     ((and (number? a1) (number? a2))
      (== a1 a2))
     ((or (number? a1) (number? a2)) #f)
     (else
      (eq? a1 a2)))))

(define eqlist?
  (lambda (l1 l2)
    (cond
     ((and (null? l1) (null? l2)) #t)
     ((or (null? l1) (null? l2)) #f)
     ((and (atom? l1) (atom? l2)) (eqan? l1 l2))
     ((or (atom? l1) (atom? l2)) #f)
     ((and (eqlist? (car l1) (car l2)) (eqlist? (cdr l1) (cdr l2))))
     (else #f)
     )))

;; eqlist? rewritten again, book version p 91, not allowing non-list args.
;; Honestly I prefer mine, though it should be named something more like eqan?
(define eqlist?
  (lambda (l1 l2)
    (cond
     ((and (null? l1) (null? l2)) #t)
     ((and (null? l1) (atom? (car l2))) #f)
     ((null? l1) #f)
     ((and (atom? (car l1)) (null? l2)) #f)
     ((and (atom? (car l1)) (atom? (car l2)))
      (and (eqan? (car l1) (car l2))
           (eqlist? (cdr l1) (cdr l2))))
     ((atom? (car l1)) #f)
     ((null? l2) #f)
     ((atom? (car l2) #f))
     (else
      (and (eqlist? (car l1) (car l2))
           (eqlist? (cdr l1) (cdr l2)))))))


;; eqlist? slightly simplified, book version p 92.
;; This one I can get behind.
(define eqlist?
  (lambda (l1 l2)
    (cond
     ((and (null? l1) (null? l2)) #t)
     ((or (null? l1) (null? l2)) #f)
     ((and (atom? (car l1)) (atom? (car l2)))
      (and (eqan? (car l1) (car l2))
           (eqlist? (cdr l1) (cdr l2))))
     ((or (atom? (car l1)) (atom? (car l2))) #f)
     (else
      (and (eqlist? (car l1) (car l2))
           (eqlist? (cdr l1) (cdr l2)))))))


(expects_eq
 #t
 (eqlist? '(strawberry ice cream) '(strawberry ice cream))
 "Two identical lats compare equal"
 )

(expects_eq
 #t
 (eqlist? '() '())
 "Two nulls compare equal"
 )

(expects_eq
 #f
 (eqlist? '() '(blah))
 "null isn't a lat"
 )

(expects_eq
 #f
 (eqlist? '(blah) '())
 "lat isn't null"
 )

(expects_eq
 #f
 (eqlist? '(blah) '(nope))
 "different lats"
 )

 (eqlist? '(almost blah) '(blah))
