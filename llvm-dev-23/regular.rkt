#lang slideshow
(require ppict/2
         racket/splicing
         pict/code
         (prefix-in mp: metapict)
         "utils.rkt")
(provide (all-defined-out))


(define (regular)
  (mp:current-inner-separation 0.2)
  (define font (mp:make-similar-font (mp:new-font) #:size 10))
  (define-sequence-nodes nodes-to-draw
    (compiler-instance-node (mp:with-font font (mp:rectangle-node "New CompilerInstance"  #:min-width 5)))
    (setup-node (mp:with-font font (mp:rectangle-node "Set up all lot of configs" #:right-of compiler-instance-node)))
    (one-tweak-node (mp:with-font font (mp:rectangle-node "FrontendOpts.CompletionAt = {\"hello_world.cpp\", 1, 2}" #:right-of setup-node #:min-width 7.3)))
    (syntax-action-node (mp:with-font font (mp:rectangle-node "New SyntaxOnlyAction" #:right-of one-tweak-node #:min-width 5)))
    (execute-node (mp:with-font font (mp:rectangle-node "Execute" #:below syntax-action-node)))
    (create-default-consumer-node (mp:with-font font (mp:rectangle-node "createDefaultPrintConsumer()" #:below execute-node)))
    (enable-completion-node (mp:with-font font (mp:rectangle-node "EnableCodeCompletion(FrontendOpts.CompletionAt)" #:below create-default-consumer-node)))
    (trigger-completion-node (mp:with-font font (mp:rectangle-node "Trigger Code Completion" #:left-of enable-completion-node)))
    (print-results (mp:with-font font (mp:rectangle-node "DefaultPrintConsumer::ProcessCompletionResults" #:left-of trigger-completion-node #:min-width 7))))


  (define edges (map mp:edge (take nodes-to-draw (sub1 (length nodes-to-draw))) (cdr nodes-to-draw)))
  ;; (define edges (list (mp:edge (car nodes-to-draw) (cadr nodes-to-draw))))

  (pslide #:title "How Code Completion Works"
          #:go (coord 0.5 0.2 'cb)
          (code-block "int foo = 42;"
                      "int res = 1 + f█")
          (code-block "clang++ -cc1 -fsyntax-only -code-completion-at=hello_world.cpp:1:2 hello_world.cpp:1:2")
          #:go (coord 0.15 0.5 'cb)
          (apply mp:draw (append nodes-to-draw edges))))

(module+ main
  (regular))
