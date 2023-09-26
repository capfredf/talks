#lang slideshow
(require "utils.rkt" racket/runtime-path
         pict/code)


(define-runtime-path whatif-rkt-eg "whatif-rkt-eg.rkt")
(define-runtime-path whatif-rkt-eg-sub "whatif-rkt-eg-sub.rkt")

(provide whatif-rkt)
(define (whatif-rkt)
  (define code-font-size (+ ((get-current-code-font-size)) 10))
  (define-values (egs lh _) (read-code whatif-rkt-eg #:font-size code-font-size))
  (match-define-values ((list sub) _ __) (read-code whatif-rkt-eg-sub #:font-size code-font-size))
  (define pter (make-code-pointer 3 0 2))

  (transition-slide #:title (cap "3. Do nothing (Racket)")
                    (coord 0.2 0.15 'lt)
                    (list (list-ref egs 0)
                          (blank code-font-size)
                          (list-ref egs 1)
                          (blank code-font-size)
                          (list-ref egs 2))
                    lh
                    (list)
                    (make-transitions 4 (make-code-pointer 0 0 1))
                    (make-transitions 0 pter)
                    (make-transitions 0 pter
                                      0 sub)
                    (make-transitions 4 (make-code-pointer 1 0 1.5))))

(module+ main
  (whatif-rkt))
