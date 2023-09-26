#lang slideshow
(require "utils.rkt" racket/runtime-path)

(define-runtime-path caveat-eg "caveat-eg.rkt")

(provide caveat)
(define (caveat)
  (transition-slide-from-file* #:title "Why only the receiver?"
                               (coord 0.25 0.2 'lt)
                               caveat-eg
                               #:reorganizer
                               (lambda (frame)
                                 (cons (vl-append (vc-append (bt "Inheritance + Function Subtyping")
                                                             (bt "=")
                                                             (bt "Extracted methods can be invariant in the receiver type?"))
                                                  (blank 30)
                                                  (bt "Counterexample")
                                                  (blank 10))
                                       frame))
                               8
                               (make-transitions 1 (make-code-pointer 0 0 +inf.0))))

(module+ main
  (caveat))
