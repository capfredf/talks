#lang slideshow
(require ppict/2
         racket/splicing
         pict/code
         (prefix-in mp: metapict)
         "../assets/asset.rkt"
         "utils.rkt")
(provide (all-defined-out))

(define (sum-up)
  (pslide #:title "Summary"
          #:layout 'center
          (item "Solved the visibility issue with ASTImporter and ExternalSource")
          (item "Enabled code completion in top level expressions with a new CompletionContext")
          (item "Leveraged Sema/* modules to achive semantic code completions")))

(module+ main
  (sum-up))
