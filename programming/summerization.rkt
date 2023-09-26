#lang slideshow
(require ppict/slideshow2 racket/draw ppict/2 (except-in "utils.rkt" placer? coord))


(provide summarize-whatif)
(define (summarize-whatif)
  (define header (map bt (list "Approach"  "Language" "Unbound Method?" "No Runtime Check?")))


  (define (make-tbl . args)
    (table (length header)
           (append header
                   (list (t "Bound Method") (t "Python")  not-okay  okay)
                   (list (t "Doing Nothing") (t "JavaScript") okay not-okay)
                   (list (t "Dynamically Checking") (t "Java") okay not-okay)
                   args)
           (cons lc-superimpose cc-superimpose)
           lc-superimpose
           (list 20 35 35)
           20))


  (pslide #:title "Summarize"
          #:go (coord 0.12 0.2 'lt)
          (make-tbl))
  (pslide #:title "Summarize"
          #:go (coord 0.12 0.2 'lt)
          (make-tbl (t "Type Checker") unknown unknown unknown)))

(provide summarize-typechecker)

(define (summarize-typechecker)
  (define header (map bt (list "Approach"  "Language" "Unbound Method?" "No Runtime Check?" "Sound?")))
  (define (make-tbl . args)
    (table (length header)
           (append header
                   (list (t "Bound Method") (t "Python")  not-okay  okay n/a)
                   (list (t "Doing Nothing") (t "JavaScript") okay not-okay n/a)
                   (list (t "Dynamically Checking") (t "Java") okay not-okay not-okay)
                   (list (t "Statically Checking") (t "Flow/TypeScript") okay okay not-okay)
                   args)
           (cons lc-superimpose (cons lc-superimpose cc-superimpose))
           lc-superimpose
           (list 15 20 20 15)
           20))
  (pslide #:title "Summarize"
          #:go (coord 0.10 0.2 'lt)
          (make-tbl))
  (pslide #:title "Summarize"
          #:go (coord 0.10 0.2 'lt)
          (make-tbl (t "Type Checker") (t "Typed Racket") okay okay okay)
          #:next
          #:go (coord 0.094 0.595 'lt)
          (rectangle (* (get-client-w #:aspect 'widescreen) 5/6) 35
                     #:border-color "crimson"
                     #:border-width 5)))

(module+ main
  ;(summarize-whatif)
  (summarize-typechecker))
