#lang slideshow
(require ppict/2
         racket/splicing
         pict/code
         (prefix-in mp: metapict)
         "utils.rkt")
(provide (all-defined-out))


(define (first-attempt)
  (mp:current-inner-separation 0.2)
  (define font (mp:make-similar-font (mp:new-font)
                                     #:size 10))
  (define compiler-instance-node (mp:with-font font (mp:rectangle-node "new IncrementalCompilerInstance")))
  (define syntax-action-node (mp:with-font font (mp:rectangle-node "new IncrementalSyntaxOnlyAction" #:right-of compiler-instance-node)))
  (define execute-node (mp:with-font font (mp:rectangle-node "Execute" #:right-of syntax-action-node)))
  (define trigger-completion-node (mp:with-font font (mp:rectangle-node "Trigger Code Completion" #:right-of execute-node)))
  (define print-results (mp:with-font font (mp:rectangle-node "DefaultConsumer::ProcessCompletionResults" #:above trigger-completion-node)))
  (define setup-node (mp:with-font font (mp:rectangle-node "set up all lot of configs" #:below compiler-instance-node)))
  (define one-tweak-node (mp:with-font font (mp:rectangle-node "FrontendOpts.CompletionAt = {\"hello_word.cpp\", 1, 2}" #:below setup-node)))
  (define create-default-consumer-node (mp:with-font font (mp:rectangle-node "createDefaultConsumer()" #:above compiler-instance-node)))
  (define enable-completion-node (mp:with-font font (mp:rectangle-node "EnableCodeCompletion(FrontendOpts.CompletionAt)" #:below execute-node)))
  (define nodes-to-draw (list compiler-instance-node
                              syntax-action-node
                              execute-node
                              trigger-completion-node
                              print-results))

  (define edges (map mp:edge (take nodes-to-draw (sub1 (length nodes-to-draw))) (cdr nodes-to-draw)))
  ;; (define edges (list (mp:edge (car nodes-to-draw) (cadr nodes-to-draw))))

  (pslide #:go (coord 0.5 0.2 'cb)
          (parameterize ([get-current-code-font-size (lambda () (- (current-font-size) 10))])
            (codeblock-pict "clang++ -cc1 -fsyntax-only -code-completion-at=hello1.cpp:1:2 hello1.cpp:1:2"))
          #:go (coord 0.2 0.5 'cb)
          (apply mp:draw (append nodes-to-draw edges (list setup-node (mp:edge setup-node compiler-instance-node)
                                                           enable-completion-node
                                                           one-tweak-node
                                                           create-default-consumer-node
                                                           (mp:edge setup-node one-tweak-node)
                                                           (mp:edge execute-node enable-completion-node)
                                                           (mp:edge execute-node create-default-consumer-node))))))

(module+ main
  (first-attempt))
