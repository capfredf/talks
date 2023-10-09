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
          (item "Implement code completion in ClangRepl by levaraging Sema/* modules")
          (item "Implement semantic code completion")))

(module+ main
  (contributions))
