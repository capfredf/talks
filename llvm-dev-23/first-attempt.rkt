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
  (define compiler-instance-node (mp:with-font font (mp:rectangle-node "New IncrementalCompilerInstance")))
  (define setup-node (mp:with-font font (mp:rectangle-node "Set up all lot of configs" #:right-of compiler-instance-node)))
  (define one-tweak-node (mp:with-font font (mp:rectangle-node "FrontendOpts.CompletionAt = {\"<<<input>>>\", 1, 2}" #:right-of setup-node)))
  (define cc-consumer-node (mp:with-font font (mp:rectangle-node "New ReplCodeCompletionConsumer" #:right-of one-tweak-node)))
  (define syntax-action-node (mp:with-font font (mp:rectangle-node "New IncrementalSyntaxOnlyAction" #:below cc-consumer-node)))
  (define execute-node (mp:with-font font (mp:rectangle-node "Execute" #:left-of syntax-action-node)))
  (define enable-completion-node (mp:with-font font (mp:rectangle-node "EnableCodeCompletion(FrontendOpts.CompletionAt)" #:left-of execute-node)))
  (define trigger-completion-node (mp:with-font font (mp:rectangle-node "Trigger Code Completion" #:left-of enable-completion-node)))
  (define results (mp:with-font font (mp:rectangle-node "ReplCodeCompletionConsumer::ProcessCompletionResults" #:below trigger-completion-node)))
  (define nodes-to-draw (list compiler-instance-node
                              setup-node
                              one-tweak-node
                              cc-consumer-node
                              syntax-action-node
                              execute-node
                              enable-completion-node
                              trigger-completion-node
                              results))

  (define edges (map mp:edge (take nodes-to-draw (sub1 (length nodes-to-draw))) (cdr nodes-to-draw)))
  ;; (define edges (list (mp:edge (car nodes-to-draw) (cadr nodes-to-draw))))

  (pslide #:go (coord 0.5 0.2 'cb)
          (parameterize ([get-current-code-font-size (lambda () (- (current-font-size) 10))])
            (repl-input "int foo = 42;" "int res = 1 + f<tab>"))
          #:go (coord 0.15 0.5 'cb)
          (apply mp:draw (append nodes-to-draw edges))))

(module+ main
  (first-attempt))
