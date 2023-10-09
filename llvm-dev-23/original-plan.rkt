#lang slideshow
(require ppict/2
         racket/splicing
         pict/code
         (prefix-in mp: metapict)
         "../assets/asset.rkt"
         "utils.rkt")
(provide (all-defined-out))

(define (what-sema-comp-needs)
  (pslide #:title "What Semantic Code Completion Needs"
          #:layout 'center
          (item (t "What context is the cursor at?"))
          (repl-input "n█")
          (repl-input "car.█")
          (item (t "How to get the type w.r.t the cursor position?"))
          (repl-input "pickOne(name1, █)")))

(module+ main
  (what-sema-comp-needs))
