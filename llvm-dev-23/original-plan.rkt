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
          #:comments ("In order to allow it to happen, we would to know the following types of information:."
                      "What context is the cursor in when we hit tab and How can we get the type w.r.t the cursor position?")
          #:layout 'center
          (item (t "What context is the cursor in?"))
          (repl-input "f█")
          (repl-input "car.█")
          (item (t "How to get the type w.r.t the cursor position?"))
          (repl-input "pickOne(name1, █)")))

(module+ main
  (what-sema-comp-needs))
