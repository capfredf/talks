#lang racket/base
(require racket/runtime-path
         (only-in slideshow scale bitmap))
(provide (all-defined-out))
(define-runtime-path iu-logo-path "iu-logo.png")
(define-runtime-path why-path "why.png")

(define (iu-logo [factor 0.5])
  (scale (bitmap iu-logo-path) factor))

(define (why [factor 0.5])
  (scale (bitmap why-path) factor))
