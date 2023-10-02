#lang slideshow
(require ppict/2
         racket/splicing
         pict/code
         (prefix-in mp: metapict)
         "../assets/asset.rkt"
         "utils.rkt")
(provide (all-defined-out))


(define (visibilty-of-decls)
  (pslide #:title "Visibility of Declarations"
          #:layout 'center
          (repl-input "int foo = 42;"
                      "int res = 1 + f█ ")))

(define (visibilty-of-decls-single-file)
  (pslide #:title "Visibility of Declarations"
          #:layout 'center
          (code-block "int foo = 42;"
                      "int res = 1 + f█ "))
  (pslide #:title "Visibility of Declarations"
          #:layout 'center
          (code-block "int foo = 42;"
                      "int res = 1 + foo")))

(define (side-by-side)
  (pslide #:title "Visibility of Declarations"
          #:layout 'center
          #:go (coord 0.2 0.5 'lb)
          (tag-pict (code-block "int foo = 42;"
                                "int res = 1 + f█ ")
                    'left)
          #:go (coord 0.5 0.5 'lb)
          (tag-pict (repl-input "int foo = 42;"
                                "int res = 1 + f█ ")
                    'right)
          #:go (coord 0.495 0.5 'lb)
          #:next
          #:alt [(rectangle 150 52 #:border-color "red" #:border-width 4)]
          #:go (at-find-pict 'left lt-find 'lt)
          (rectangle 250 60 #:border-color "red" #:border-width 4)
          (text "ONE ASTContxt" null 20)
          #:next
          #:go (at-find-pict 'right lt-find 'lt)
          (rectangle 400 30 #:border-color "red" #:border-width 4)
          (rectangle 400 30 #:border-color "red" #:border-width 4)
          (text "TWO ASTContxts" null 20)))


(module+ main
  (visibilty-of-decls)
  (visibilty-of-decls-single-file)
  (side-by-side))
