#lang slideshow
(require ppict/2
         racket/splicing
         pict/code
         (prefix-in mp: metapict)
         "utils.rkt")
(provide (all-defined-out))

(define (new-attempt)
  (mp:current-inner-separation 0.2)
  (define input "int res = 1 + n⇥")
  (define col (get-code-completion-at input))
  (define font (mp:make-similar-font (mp:new-font)
                                     #:size 10))
  (define (animate)
    (define-sequence-nodes extras
      ;; [compiler-instance-node (mp:with-font font (mp:rectangle-node "New IncrementalCompilerInstance"))]
      [ast-unit-node (regular-node "ASTUnit* au = LoadFromCompilerInvocationAction(New IncrementalCI)" #;#; #:right-of compiler-instance-node)]

      ;; (define ccc-at-node (mp:with-font font (mp:rectangle-node "{\"<<<input>>>\", 1, 2}" #:below compiler-instance-node)))
      ;; (define act-node (mp:with-font font (mp:rectangle-node "New IncrementalStxOnlyAction" #:below ccc-at-node)))
      [ast-unit-cc-node (regular-node (format "au->codeComplete({\"<<<input>>>\", 1, ~a}, New IncrementalStxOnlyAct, New ReplCodeCompletion)" col)
                                     #:right-of ast-unit-node)]
      [begin-source-file (mp:with-font font (mp:rectangle-node "BeginSourceFile" #:below ast-unit-cc-node))]
      [execute-node (mp:with-font font (mp:rectangle-node "Execute" #:below begin-source-file))]
      [enable-completion-node (mp:with-font font (mp:rectangle-node "EnableCodeCompletion(FrontendOpts.CompletionAt)" #:below execute-node))]
      [trigger-completion-node (mp:with-font font (mp:rectangle-node "Trigger Code Completion" #:left-of enable-completion-node))]
      [results (regular-node "ReplCodeCompletionConsumer::ProcessCompletionResults" #:left-of trigger-completion-node)])
    ;; (define ccc-node (mp:with-font font (mp:rectangle-node "New ReplCodeCompletion" #:below act-node)))
    ;; (define left-nodes (list ccc-at-node act-node ccc-node))
    (for/fold ([acc 0])
              ([i (in-list '(1 1 3 2))])
      (let ([extras (take extras (+ acc i))])
        (define edges (map mp:edge (take extras (sub1 (length extras))) (cdr extras)))
        (pslide #:title "Using ASTUnit"
                #:go (coord 0.5 0.2 'cb)
                (repl-input "int num = 42;" input)
                #:go (coord 0.23 0.5 'cb)
                (apply mp:draw extras edges;;(append left-nodes edges (list ASTUnitCC-node) extras)
                       )))
      (+ acc i)))
  (define (static)
    (define-sequence-nodes extras
      ;; [compiler-instance-node (mp:with-font font (mp:rectangle-node "New IncrementalCompilerInstance"))]
      [ast-unit-node (my-job-node "ASTUnit* au = LoadFromCompilerInvocationAction(New IncrementalCI)" #;#; #:right-of compiler-instance-node)]

      ;; (define ccc-at-node (mp:with-font font (mp:rectangle-node "{\"<<<input>>>\", 1, 2}" #:below compiler-instance-node)))
      ;; (define act-node (mp:with-font font (mp:rectangle-node "New IncrementalStxOnlyAction" #:below ccc-at-node)))
      [ast-unit-cc-node (my-job-node (format "au->codeComplete({\"<<<input>>>\", 1, ~a}, New IncrementalStxOnlyAct, New ReplCodeCompletion)" col)
                                     #:right-of ast-unit-node)]
      [begin-source-file (mp:with-font font (mp:rectangle-node "BeginSourceFile" #:below ast-unit-cc-node))]
      [execute-node (mp:with-font font (mp:rectangle-node "Execute" #:below begin-source-file))]
      [enable-completion-node (mp:with-font font (mp:rectangle-node "EnableCodeCompletion(FrontendOpts.CompletionAt)" #:below execute-node))]
      [trigger-completion-node (mp:with-font font (mp:rectangle-node "Trigger Code Completion" #:left-of enable-completion-node))]
      [results (my-job-node "ReplCodeCompletionConsumer::ProcessCompletionResults" #:left-of trigger-completion-node)])
    ;; (define ccc-node (mp:with-font font (mp:rectangle-node "New ReplCodeCompletion" #:below act-node)))
    ;; (define left-nodes (list ccc-at-node act-node ccc-node))
    (define edges (map mp:edge (take extras (sub1 (length extras))) (cdr extras)))
    (pslide #:title "Using ASTUnit"
            #:go (coord 0.5 0.2 'cb)
            (repl-input "int num = 42;" input)
            #:go (coord 0.08 0.23 'lt)
            (hc-append (mp:draw (my-job-node "       ")) (text "New Code" 'default 20))
            #:go (coord 0.23 0.5 'cb)
            (apply mp:draw extras edges;;(append left-nodes edges (list ASTUnitCC-node) extras)
                   )))
  (animate)
  (static))

(module+ main
  (new-attempt))
