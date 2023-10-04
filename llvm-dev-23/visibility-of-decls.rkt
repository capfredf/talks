#lang slideshow
(require ppict/2
         racket/splicing
         pict/code
         (prefix-in mp: metapict)
         "../assets/asset.rkt"
         "utils.rkt")
(provide (all-defined-out))

(define slide-title "Declaration Visibility Issue")

(define (side-by-side)
  (pslide #:title slide-title
          #:layout 'center
          #:go (coord 0.2 0.5 'lb)
          (tag-pict (code-block "int foo = 42;"
                                "int res = 1 + f█ ")
                    'left)
          #:go (coord 0.5 0.5 'lb)
          (tag-pict (repl-input "int foo = 42;"
                                "int res = 1 + f█ ")
                    'right))

  (pslide #:title slide-title
          #:layout 'center
          #:go (coord 0.2 0.5 'lb)
          (tag-pict (code-block "int foo = 42;"
                                "int res = 1 + foo█")
                    'left)
          #:go (coord 0.5 0.5 'lb)
          (tag-pict (repl-input "int foo = 42;"
                                "int res = 1 + f█  ")
                    'right)
          #:go (coord 0.495 0.5 'lb)
          #:next
          #:alt [(rectangle 150 52 #:border-color "red" #:border-width 4)]
          #:go (at-find-pict 'left lt-find 'lt)
          (rectangle 250 60 #:border-color "red" #:border-width 4)
          (text "ONE ASTContext" null 20)
          #:go (at-find-pict 'right lt-find 'lt)
          (rectangle 400 30 #:border-color "red" #:border-width 4)
          (rectangle 400 30 #:border-color "red" #:border-width 4)
          (text "TWO ASTContexts" null 20)))

(define deltas (list "int flight = 84;" "int fruit = 76;" "int foo = 42;" "int res = 1 + f█ "))

(define font (mp:make-similar-font (mp:new-font)
                                   #:size 10))

(define (new-main-ast-node)
  (mp:with-font font (mp:rectangle-node "MainAstContext" #:fill "orange")))

(define (new-current-ast-node main-node)
  (mp:with-font font (mp:rectangle-node "CurrentAstContext" #:right-of main-node #:fill "blue")))


(define (merge-contexts3)
  (define font (mp:make-similar-font (mp:new-font)
                                     #:size 10))
  (parameterize ([mp:current-inner-separation 0.2]
                 [mp:current-neighbour-distance 5])
    (define main-node0 (new-main-ast-node))
    (define current-node0 (new-current-ast-node  main-node0))
    (define edge0 (mp:edge main-node0 current-node0 #:label ".setExternalSource"))
    (define main-node (new-main-ast-node))
    (define current-node (new-current-ast-node main-node))
    (define edge (mp:edge main-node current-node #:label "ASTImporter::import"))
    (define slide-title^ (string-append "Solution to " slide-title))
    (pslide #:title slide-title^
            #:go (coord 0.4 0.5 'cb)
            (apply repl-input "..." deltas)
            #:go (coord 0.3 0.7 'cb)
            (mp:draw main-node0 current-node0 edge0)
            #:go (coord 0.3 0.8 'cb)
            (mp:draw main-node current-node edge))

    (define decls (list "foo" "fruit" "flight"))
    (for ([(_ idx) (in-indexed decls)])
      (define nodes (for/list ([(t i) (in-indexed (take decls (add1 idx)))])
                      (mp:with-font font (mp:rectangle-node t #:at (mp:pt 11 (- 1 i))))))
      (pslide #:title slide-title^
              #:go (coord 0.4 0.5 'cb)
              (tag-pict (apply repl-input "..." deltas) 'repl-input)
              #:go (coord 0.3 0.7 'cb)
              (mp:draw main-node0 current-node0 edge0)
              #:go (coord 0.3 0.8 'cb)
              (mp:draw main-node current-node edge nodes
                       (map (lambda (n)
                              (mp:edge current-node n))
                            nodes))
              #:go (at-find-pict 'repl-input lt-find 'lt #:abs-y (- 90 (* 30 idx)))
              (rectangle 400 25 #:border-color "red" #:border-width 4)))))


(define (visibility-of-decls)
  (side-by-side)
  (merge-contexts3))

(module+ main
  (visibility-of-decls))
