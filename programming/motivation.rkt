#lang slideshow
(require racket/runtime-path "utils.rkt")

(provide motivation)
(define (motivation)
  (slide #:title "Why care about extracted methods"
         (item "type system support for such patterns in existing code")
         (item "A type-safe low-level building block for high-level features")))

(module+ main
  (motivation))
