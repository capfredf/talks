#lang slideshow
(require ppict/2
         racket/splicing
         pict/code
         (prefix-in mp: metapict)
         "../assets/asset.rkt"
         "utils.rkt")
(provide (all-defined-out))


(define (contributions)
  (pslide #:title "Contributions"
          (item "Overcame challenges of using Sema/CodeComplete in REPL to implement basic code completion")
          (item "Utilized key structures in Sema for semantic code completion")))

(module+ main
  (contributions))
