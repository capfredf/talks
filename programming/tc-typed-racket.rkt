#lang slideshow
(require "utils.rkt" racket/runtime-path)

(define-runtime-path tc-ts-eg "tc-typed-racket-eg.rkt")

(provide tc-tr)
(define (tc-tr)
  (parameterize ([layout (hash 'declaration 11
                               'initialization 2
                               'extraction 2
                               'application 10)])
    (transition-slide-from-file* #:title (string-append (cap "Sound Method Extraction") " in Typed Racket")
                                 (coord 0.1 0.12 'lt)
                                 tc-ts-eg
                                 6
                                 (make-transitions 1 (make-code-pointer 0 0 +inf.0))
                                 (make-transitions 2 (make-code-pointer))
                                 (make-transitions 3 (make-code-pointer))
                                 (make-transitions 3 (make-code-pointer 1 0))
                                 (make-transitions 3 (make-code-pointer 2 0))
                                 (make-transitions 3 (make-code-pointer 3 0)))))

(module+ main
  (tc-tr))
