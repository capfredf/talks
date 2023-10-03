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
          (repl-input "f█")
          (repl-input "strlen(█")
          (repl-input "apple.█")
          #:next
          #:go (at-find-pict 'text lc-find 'lc)
          (hline 500 5)
          #:go (at-find-pict 'text lt-find 'lb)
          (t "Clang/Parse* do it for me"))
  (define type-str "createNewFoo : Int -> String -> Foo")
  (define type-pict (tt type-str))
  (define StringPos (string-length (car (string-split type-str "String"))))
  (pslide #:title "Original Plan"
          #:layout 'center
          (item (tag-pict (t "Get type information w.r.t. the cursor position") 'text))
          #:next
          (repl-input "foo.merge({1, 2, 3}, createNewFoo(10, █")
          #:next
          (tag-pict type-pict 'type)
          #:next
          #:go (at-find-pict 'type lt-find 'lt #:abs-x (* StringPos (pict-width (tt "h"))))
          (rectangle (pict-width (tt "String")) (pict-height type-pict) #:border-color "orange" #:border-width 3)
          #:next
          #:go (at-find-pict 'text lc-find 'lc)
          (hline 700 5)
          #:go (at-find-pict 'text lt-find 'lb)
          (t "Sema/* do it for me")))

(module+ main
  (original-plan))
