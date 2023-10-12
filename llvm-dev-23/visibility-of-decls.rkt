#lang slideshow
(require ppict/2
         racket/splicing
         pict/code
         (prefix-in mp: metapict)
         "../assets/asset.rkt"
         "utils.rkt")
(provide (all-defined-out))

(define slide-title "Declaration Visibility Issue")

(define deltas (list "int num1 = 84;" "int num2 = 76;" "int num3 = 42;" "int res = 1 + n⇥  "))
(define deltas-over (list "int num1 = 84;" "int num2 = 76;" "int num3 = 42;" (list "int res = 1 + n█ ") (list "num1" "num2" "num3")))
(define deltas-cursor (list "int num1 = 84;" "int num2 = 76;" "int num3 = 42;" "int res = 1 + n█ "))
(define (side-by-side)
  (pslide #:title slide-title
          #:comments ("One challenge we faced is that the code completion system couldn't see the declarations defined before the current line. To illustrate the problem, here we compare code completion in a regular file with that in REPL using the same content")
          #:go (coord 0.2 0.4 'lt)
          (apply code-block deltas #:font-size 25)
          #:go (coord 0.5 0.4 'lt)
          (apply repl-input deltas #:font-size 25))

  (pslide #:title slide-title
          #:comments ("The difference is that the code completion system can see all the declarations defined in the file but in REPL, it can't see any declarations defined before the current line")
          #:go (coord 0.2 0.4 'lt)
          (tag-pict (apply code-input/with-output deltas-over #:font-size 25)
                    'left)
          #:go (coord 0.5 0.4 'lt)
          (tag-pict (apply repl-input deltas-cursor #:font-size 25)
                    'right)
          ;; #:go (coord 0.495 0.5 'lb)
          ;; #:next
          ;; #:alt [(rectangle 150 52 #:border-color "red" #:border-width 4)]
          ;; #:go (at-find-pict 'left lt-find 'lt)
          ;; (rectangle 250 60 #:border-color "red" #:border-width 4)
          ;; (text "ONE ASTContext" null 20)
          ;; #:go (at-find-pict 'right lt-find 'lt)
          ;; (rectangle 400 30 #:border-color "red" #:border-width 4)
          ;; (rectangle 400 30 #:border-color "red" #:border-width 4)
          #;
          (text "TWO ASTContexts" null 20))

  (define regular-pict (apply code-block deltas  #:font-size 25))
  (define repl-pict (apply repl-input deltas  #:font-size 25))
  #;
  (pslide #:title slide-title
          #:layout 'tall
          (t "Why does code completion fail to see previously defined declaration in REPL?")
          (item "A file is one single translation unit defined by one ASTContext")
          (tag-pict regular-pict 'regular)
          #:go (at-find-pict 'regular lt-find 'lt #:abs-x -2 #:abs-y -2)
          (tag-pict (rectangle (+ 4 (pict-width regular-pict)) (+ 4 (pict-height regular-pict)) #:border-color "red" #:border-width 4) 'highlight)
          #:go (at-find-pict 'highlight lb-find 'lt #:abs-x -10 #:abs-y 5)
          (text "1 ASTContext & 1 TranslationUnit" null 20))

  (pslide #:title slide-title
          #:layout 'top
          (t "Why does the code completion system fail to see previously defined declarations in REPL?")
          (item "A file is one single translation unit enclosed by one ASTContext")
          (tag-pict regular-pict 'regular)
          #:go (at-find-pict 'regular lt-find 'lt #:abs-x -2 #:abs-y -2)
          (tag-pict (rectangle (+ 4 (pict-width regular-pict)) (+ 4 (pict-height regular-pict)) #:border-color "red" #:border-width 4) 'highlight)
          #:go (at-find-pict 'highlight lb-find 'lt #:abs-x -10 #:abs-y 5)
          40
          (text "1 ASTContext & 1 TranslationUnit" null 30))


  (pslide #:title slide-title
          #:layout 'top
          (t "Why does the code completion system fail to see previously defined declarations in REPL?")
          (item "A REPL session contains multiple partial translation units enclosed by two ASTContexts")
          (tag-pict repl-pict 'pict)
          #:go (at-find-pict 'pict lt-find 'lt #:abs-x -2 #:abs-y -2)
          (rectangle (+ 4 (pict-width repl-pict)) (+ 1 (/ (pict-height repl-pict) 4)) #:border-color "red" #:border-width 4)
          (rectangle (+ 4 (pict-width repl-pict)) (+ 1 (/ (pict-height repl-pict) 4)) #:border-color "red" #:border-width 4)
          (rectangle (+ 4 (pict-width repl-pict)) (+ 1 (/ (pict-height repl-pict) 4)) #:border-color "red" #:border-width 4)
          (rectangle (+ 4 (pict-width repl-pict)) (+ 1 (/ (pict-height repl-pict) 4)) #:border-color "red" #:border-width 4)
          #; (colorize (hline (+ 4 (pict-width repl-pict)) (+ 4 (* 1 (/ (pict-height repl-pict) 4)))) "red")
          ;; (rectangle (+ 4 (pict-width repl-pict)) (+ 4 (pict-height repl-pict)) #:border-color "red" #:border-width 4)
          ;; (rectangle (+ 4 (pict-width repl-pict)) (+ 4 (pict-height repl-pict)) #:border-color "red" #:border-width 4)
          ;; #:go (at-find-pict 'highlight lb-find 'lt #:abs-x -10 #:abs-y 5)
          (text "2 ASTContexts & 4 PartialTranslationUnits" null 30)
          #;(rectangle 400 30 #:border-color "red" #:border-width 4)
          #;#;#;
          #:go (coord 0.1 0.6 'lt)
          (subitem "Note that we also cannot pollute other translation units when doing completion."))

  #;
  (pslide #:title slide-title
          #:layout 'center
          #:go (coord 0.2 0.5 'lb)
          (tag-pict (code-block "int num = 42;"
                                "int res = 1 + num█")
                    'left)
          #:go (coord 0.5 0.5 'lb)
          (tag-pict (repl-input "int num = 42;"
                                "int res = 1 + n█  ")
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



(define font (mp:make-similar-font (mp:new-font)
                                   #:size 10))

(define (new-main-ast-node)
  (mp:with-font font (mp:rectangle-node "MainAstContext" #:fill "orange")))

(define (new-current-ast-node main-node)
  (mp:with-font font (mp:rectangle-node "CurrentAstContext" #:right-of main-node #:fill "sky blue")))


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
    #;
    (pslide #:title slide-title^
            (item "make the main ASTContext an ExternalSource of the current ASTContext")
            (item "use ASTImporter to import every decl from the Main ASTContext to the current one"))

    (pslide #:title slide-title^
            #:comments ("to solve this issue, we resorted to two methods: SetExternalSource of ASTContext and the Import method of ASTImporter"
                        "Using the example we have here, we first make the main ast context an ExternalSource of the current ast context")
            #:go (coord 0.4 0.5 'cb)
            (apply repl-input "..." deltas  #:font-size 25)
            #:go (coord 0.3 0.7 'cb)
            (mp:draw main-node0 current-node0 edge0)
            #:go (coord 0.3 0.8 'cb)
            (mp:draw main-node current-node edge))

    (define decls (list "num3" "num2" "num1"))
    (let ([deltas (cons "..." deltas)])
      (define data (tag-pict (apply repl-input deltas #:font-size 25) 'repl-input))
      (define ht (/ (pict-height data) (length deltas)))
      (for ([(_ idx) (in-indexed decls)])
        (define nodes (for/list ([(t i) (in-indexed (take decls (add1 idx)))])
                        (mp:with-font font (mp:rectangle-node t #:at (mp:pt 11 (- 1 i))))))
        (pslide #:title slide-title^
                #:comments ("Next, we import each declarations that have been defined:num3, num2, and num1 ")
                #:go (coord 0.4 0.5 'cb)
                data
                #:go (coord 0.3 0.7 'cb)
                (mp:draw main-node0 current-node0 edge0)
                #:go (coord 0.3 0.8 'cb)
                (mp:draw main-node current-node edge nodes
                         (map (lambda (n)
                                (mp:edge current-node n))
                              nodes))
                #:go (at-find-pict 'repl-input lt-find 'lt #:abs-y (- (pict-height data) (* ht (+ 2 idx))))
                (rectangle 400 ht #:border-color "red" #:border-width 4))))))


(define (visibility-of-decls)
  (side-by-side)
  (merge-contexts3))

(module+ main
  (visibility-of-decls))
