#lang slideshow
(require ppict/2
         racket/splicing
         racket/draw
         pict/code
         (prefix-in mp: metapict)
         "../assets/asset.rkt"
         "utils.rkt")
(provide (all-defined-out))

(define (new-context)
  (pslide #:title "New Completion Context Kind"
          #:layout 'center
          (tag-pict (repl-input "int foo = 42;"
                                "1 + f█ ")
                    'repl)
          #:go (at-find-pict 'repl lb-find 'lb #:abs-x 150)
          (rectangle 200 30 #:border-color "red" #:border-width 4)
          #:next
          #:go (coord 0.4 0.6 'lt)
          #:alt [(text "CompletionContext::Kind = CCC_TopLevel" (list (make-object color% "red")) 20)]
          (text "CompletionContext::Kind = CCC_TopLevelOrExpression" (list (make-object color% "dark green")) 20))

  (pslide #:title "New Completion Context Kind"
          #:layout 'center
          (tag-pict (repl-input "int foo = 42;"
                                "1 + foo ")
                    'repl)
          #:go (coord 0.4 0.6 'lt)
          (text "CompletionContext::Kind = CCC_TopLevelOrExpression" (list (make-object color% "dark green")) 20)))


(module+ main
  (new-context))
