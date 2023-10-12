#lang slideshow
(require ppict/2
         racket/splicing
         pict/code
         (prefix-in mp: metapict)
         "../assets/asset.rkt"
         "utils.rkt")
(provide (all-defined-out))


(define (contributions)
  (pslide (para "Overcame challenges of reusing Sema/CodeComplete in REPL to implement code completion")))

(module+ main
  (contributions))
