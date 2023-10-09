#lang racket/base
(require racket/runtime-path
         (only-in slideshow scale bitmap))
(provide (all-defined-out))

(define ((img-func path) [factor 0.5])
  (scale (bitmap path) factor))

(define-syntax-rule (define-static-img name filepath)
  (begin
    (define-runtime-path path filepath)
    (define name (img-func path))))

(define-static-img iu-logo "iu-logo.png")
(define-static-img compiler-research-team-logo "compiler-research-team-logo.png")
(define-static-img why "why.png")

(define-static-img gsoc-logo "gsoc.png")
