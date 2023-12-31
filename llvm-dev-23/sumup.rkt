#lang slideshow
(require ppict/2
         racket/splicing
         pict/code
         (prefix-in mp: metapict)
         "../assets/asset.rkt"
         "utils.rkt")
(provide (all-defined-out))

(define (conclusions)
  (pslide #:title "Conclusions"
          #:layout 'center
          (item "Solved the visibility issue with ASTImporter and ExternalSource")
          (item "Enabled code completion in top level expressions with a new CompletionContext")
          (item "Leveraged Sema modules to achieve semantic code completions")
          (item "Concise implementation with minimal invasive changes")))

(module+ main
  (conclusions))
