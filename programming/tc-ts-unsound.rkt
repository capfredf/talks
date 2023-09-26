#lang slideshow
(require "utils.rkt" racket/runtime-path
         pict/face
         pict/code ppict/slideshow2)


(define-runtime-path tc-ts-eg "tc-ts-unsound.ts")
(define-runtime-path tc-ts-eg-sub "tc-ts-unsound-sub.ts")
(define-runtime-path tc-ts-eg-sub2 "tc-ts-unsound-sub2.ts")

(provide tc-ts-unsound)
(define (tc-ts-unsound)
  (define code-font-size (+ ((get-current-code-font-size)) 8))
  (define-values (egs lh _) (read-code tc-ts-eg #:font-size code-font-size))
  (match-define-values ((list sub) _ _) (read-code tc-ts-eg-sub #:font-size code-font-size))
  (match-define-values ((list sub2) _ _) (read-code tc-ts-eg-sub2 #:font-size code-font-size))


  (define seqs (generate-transition-seq (list (list-ref egs 0)
                                              (list-ref egs 1)
                                              (list-ref egs 2)
                                              (list-ref egs 3)
                                              (list-ref egs 4)
                                              (list-ref egs 5)
                                              (list-ref egs 6))
                                        (list
                                         (make-transitions 0 (make-code-pointer 0 0 +inf.0))
                                         (make-transitions 1 (make-code-pointer 0 0 +inf.0))
                                         (make-transitions 3 (make-code-pointer))
                                         (make-transitions 4 (make-code-pointer))
                                         (make-transitions 5 (make-code-pointer))
                                         (make-transitions 1 (make-code-pointer 8 0 4))
                                         (make-transitions 1 (make-code-pointer 8 0 4)
                                                           1 sub)
                                         (make-transitions 1 (make-code-pointer 8 0 4)
                                                           1 sub2)
                                         (make-transitions 6 (make-code-pointer)))
                                        lh))
  (for ([t (in-list seqs)])
    (pslide #:title (string-append (cap "Unsound Method Extraction") " in TypeScript with Subclassing")
            #:go (pp:coord 0.07 0.1 'lt)
            (list-ref t 0)
            #:go (pp:coord 0.5 0.1 'lt)
            (list-ref t 1)
            #:go (pp:coord 0.25 0.72 'lt)
            20
            (list-ref t 2)
            5
            (list-ref t 3)
            (list-ref t 4)
            (list-ref t 5)
            (list-ref t 6))))

(module+ main
  (tc-ts-unsound))
