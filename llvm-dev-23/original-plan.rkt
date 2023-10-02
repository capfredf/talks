#lang slideshow
(require ppict/2
         racket/splicing
         pict/code
         (prefix-in mp: metapict)
         "../assets/asset.rkt"
         "utils.rkt")
(provide (all-defined-out))


(define (original-plan)
  (pslide #:title "Original Plan"
          #:layout 'center
          (item (tag-pict (t "Parse the current line of input") 'text))
          (repl-input "foo.merge({1, 2, 3}, createNewFoo(█")
          #:next
          #:go (at-find-pict 'text lc-find 'lc)
          (hline 500 5)
          #:go (at-find-pict 'text lt-find 'lb)
          (t "Clang/Parse* do it for me")))

(module+ main
  (original-plan))
