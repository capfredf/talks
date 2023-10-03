#lang slideshow
(require ppict/2
         racket/splicing
         pict/code
         (prefix-in mp: metapict)
         "utils.rkt")
(provide (all-defined-out))

(define (new-attempt)
  (mp:current-inner-separation 0.2)
  (define font (mp:make-similar-font (mp:new-font)
                                     #:size 10))
  (define-sequence-nodes extras
    [compiler-instance-node (mp:with-font font (mp:rectangle-node "New IncrementalCompilerInstance"))]
    [ast-unit-node (mp:with-font font (mp:rectangle-node "au = ASTUnit::LoadFromCompilerInvocationAction" #:right-of compiler-instance-node))]

    ;; (define ccc-at-node (mp:with-font font (mp:rectangle-node "{\"<<<input>>>\", 1, 2}" #:below compiler-instance-node)))
    ;; (define act-node (mp:with-font font (mp:rectangle-node "New IncrementalStxOnlyAction" #:below ccc-at-node)))
    [ast-unit-cc-node (mp:with-font font (mp:rectangle-node "au->codeComplete({\"<<<input>>>\", 1, 2}, New IncrementalStxOnlyAction, New ReplCodeCompletion)" #:right-of ast-unit-node))]
    [execute-node (mp:with-font font (mp:rectangle-node "Execute" #:below ast-unit-cc-node))]
    [enable-completion-node (mp:with-font font (mp:rectangle-node "EnableCodeCompletion(FrontendOpts.CompletionAt)" #:left-of execute-node))]
    [trigger-completion-node (mp:with-font font (mp:rectangle-node "Trigger Code Completion" #:left-of enable-completion-node))]
    [results (mp:with-font font (mp:rectangle-node "ReplCodeCompletionConsumer::ProcessCompletionResults" #:below trigger-completion-node))])
  ;; (define ccc-node (mp:with-font font (mp:rectangle-node "New ReplCodeCompletion" #:below act-node)))
  ;; (define left-nodes (list ccc-at-node act-node ccc-node))
  (define edges (map mp:edge (take extras (sub1 (length extras))) (cdr extras)))
  (pslide #:go (coord 0.5 0.2 'cb)
          (repl-input "int foo = 42;" "int res = 1 + f<tab>")
          #:go (coord 0.15 0.5 'cb)
          (apply mp:draw extras edges;;(append left-nodes edges (list ASTUnitCC-node) extras)
                 )))

(module+ main
  (new-attempt))
