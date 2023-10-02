#lang slideshow
(require ppict/2
         racket/splicing
         pict/code
         (prefix-in mp: metapict)
         "../assets/asset.rkt"
         "utils.rkt")
(provide (all-defined-out))


(define (visibility-of-decls-repl)
  (pslide #:title "Visibility of Declarations"
          #:layout 'center
          (repl-input "int foo = 42;"
                      "int res = 1 + f█ ")))

(define (visibility-of-decls-single-file)
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

(define deltas (list "int flight = 84;" "int fruit = 76;" "int foo = 42;" "int res = 1 + f█ "))
(define (merge-contexts1)
  ;; (pslide #:title "Visibility of Declarations"
  ;;         #:go (coord 0.5 0.5 'cb)
  ;;         (repl-input "int foo = 42;"
  ;;                     "int res = 1 + f█ "))
  (for ([i (in-range 3 -1 -1)])
    (pslide #:title "Visibility of Declarations"
            #:go (coord 0.4 0.5 'cb)
            (apply repl-input (drop deltas i)))))

(define (merge-contexts3)
  (define font (mp:make-similar-font (mp:new-font)
                                     #:size 10))
  (parameterize ([mp:current-inner-separation 0.2]
                 [mp:current-neighbour-distance 5])
    (define main-node (mp:with-font font (mp:rectangle-node "MainAstContext")))
    (define current-node (mp:with-font font (mp:rectangle-node "CurrentAstContext" #:right-of main-node)))
    (define edge (mp:edge main-node current-node #:label "ASTImporter::import"))
    (pslide #:title "Visibility of Declarations"
            #:go (coord 0.4 0.5 'cb)
            (apply repl-input "..." deltas)
            #:go (coord 0.3 0.7 'cb)
            (mp:draw main-node current-node edge))

    (define decls (list "foo" "fruit" "flight"))
    (for ([(_ idx) (in-indexed decls)])
      (define nodes (for/list ([(t i) (in-indexed (take decls (add1 idx)))])
                      (mp:with-font font (mp:rectangle-node t #:at (mp:pt 11 (- 1 i))))))
      (pslide #:title "Visibility of Declarations"
              #:go (coord 0.4 0.5 'cb)
              (tag-pict (apply repl-input "..." deltas) 'repl-input)
              #:go (coord 0.3 0.7 'cb)
              (mp:draw main-node current-node edge nodes
                       (map (lambda (n)
                              (mp:edge current-node n))
                            nodes))
              #:go (at-find-pict 'repl-input lt-find 'lt #:abs-y (- 90 (* 30 idx)))
              (rectangle 400 25 #:border-color "red" #:border-width 4)))))


(define (visibility-of-decls)
  ;; (visibility-of-decls-repl)
  ;; (visibility-of-decls-single-file)
  ;; (side-by-side)
  ;;(merge-contexts1)
  (merge-contexts3))

(module+ main
  (merge-contexts3))
