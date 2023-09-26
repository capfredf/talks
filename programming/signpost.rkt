#lang slideshow
(require racket/runtime-path "utils.rkt")

(define-runtime-path eg-path "signpost.js")
(define-runtime-path eg2-path "signpost2.js")
(define-runtime-path eg3-path "signpost-sugared.js")
(provide signpost)
(define (signpost2)
  (transition-slide-from-file* #:title (cap "the problem")
                               #:reorganizer
                               (λ (frame)
                                 (list-insert frame 0
                                              (ht-append (t "an Object = a Record of (States + Functions)")
                                               (rectangle 250 60 #:border-color "white"))))
                               (coord 0.2 0.13 'lt)
                               eg-path
                               12
                               (make-transitions 1 (make-code-pointer 0 0 +inf.0))
                               (make-transitions 2 (make-code-pointer 0 0 +inf.0))))

(define (signpost3)
  (transition-slide-from-file* #:title (cap "the problem")
                               #:reorganizer
                               (λ (frame)
                                 (list-insert frame 0
                                              (ht-append (t "an Object = a Record of (States + Functions)")
                                               (rectangle 250 60 #:border-color "white"))))
                               (coord 0.2 0.13 'lt)
                               eg2-path
                               12
                               (make-transitions 2 (make-code-pointer 0 0 +inf.0))))

(define (signpost1)
  (transition-slide-from-file* #:title (cap "the problem")
                               (coord 0.2 0.13 'lt)
                               eg3-path
                               12
                               (make-transitions 1 (make-code-pointer 0 0 +inf.0))))

(define (signpost)
  (signpost1)
  (signpost2)
  (signpost3))

(module+ main
  (signpost))
