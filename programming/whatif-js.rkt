#lang slideshow
(require "utils.rkt" racket/runtime-path
         pict/code)


(define-runtime-path whatif-js-eg "whatif.js")
(define-runtime-path whatif-js-eg-sub "whatif-sub.js")
(define-runtime-path whatif-js-eg-sub2 "whatif-sub2.js")


(provide whatif-js)
(define (whatif-js)
  (define code-font-size (+ ((get-current-code-font-size)) 10))
  (define-values (egs lh __) (read-code whatif-js-eg #:font-size code-font-size))
  (match-define-values ((list sub) _ _) (read-code whatif-js-eg-sub #:font-size code-font-size))
  (match-define-values ((list sub2) _ _) (read-code whatif-js-eg-sub2 #:font-size code-font-size))
  (define pter (make-code-pointer 6 0
                             1))

  (transition-slide #:title (cap "3. Do nothing (JavaScript)")
                    (coord 0.2 0.15 'lt)
                    (list (list-ref egs 0)
                          (blank code-font-size)
                          (list-ref egs 1)
                          (list-ref egs 2)
                          (list-ref egs 3))
                    lh
                    (list)
                    (make-transitions 3 (make-code-pointer))
                    (make-transitions 0 pter)
                    (make-transitions 0 pter
                                      0 sub)
                    (make-transitions 0 pter
                                      0 sub2)
                    (make-transitions 4 (make-code-pointer))))


(module+ main
  (whatif-js))
