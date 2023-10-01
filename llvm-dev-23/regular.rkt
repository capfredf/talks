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
  (define compiler-instance-node (mp:with-font font (mp:rectangle-node "New CompilerInstance")))
  (define setup-node (mp:with-font font (mp:rectangle-node "Set up all lot of configs" #:right-of compiler-instance-node)))
  (define one-tweak-node (mp:with-font font (mp:rectangle-node "FrontendOpts.CompletionAt = {\"hello_word.cpp\", 1, 2}" #:right-of setup-node)))
  (define syntax-action-node (mp:with-font font (mp:rectangle-node "New SyntaxOnlyAction" #:right-of one-tweak-node)))
  (define execute-node (mp:with-font font (mp:rectangle-node "Execute" #:right-of syntax-action-node)))
  (define create-default-consumer-node (mp:with-font font (mp:rectangle-node "createDefaultConsumer()" #:below execute-node)))
  (define enable-completion-node (mp:with-font font (mp:rectangle-node "EnableCodeCompletion(FrontendOpts.CompletionAt)" #:left-of create-default-consumer-node)))
  (define trigger-completion-node (mp:with-font font (mp:rectangle-node "Trigger Code Completion" #:left-of enable-completion-node)))
  (define print-results (mp:with-font font (mp:rectangle-node "DefaultConsumer::ProcessCompletionResults" #:left-of trigger-completion-node)))
  (define nodes-to-draw (list compiler-instance-node
                              setup-node
                              one-tweak-node
                              syntax-action-node
                              execute-node
                              create-default-consumer-node
                              enable-completion-node
                              trigger-completion-node
                              print-results))

  (define edges (map mp:edge (take nodes-to-draw (sub1 (length nodes-to-draw))) (cdr nodes-to-draw)))
  ;; (define edges (list (mp:edge (car nodes-to-draw) (cadr nodes-to-draw))))

  (pslide #:go (coord 0.5 0.2 'cb)
          (parameterize ([get-current-code-font-size (lambda () (- (current-font-size) 10))])
            (codeblock-pict "clang++ -cc1 -fsyntax-only -code-completion-at=hello1.cpp:1:2 hello1.cpp:1:2"))
          #:go (coord 0.15 0.5 'cb)
          (apply mp:draw (append nodes-to-draw edges))))

(module+ main
  (regular))
