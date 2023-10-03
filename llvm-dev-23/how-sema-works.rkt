#lang slideshow
(require ppict/2
         racket/splicing
         pict/code
         (prefix-in mp: metapict)
         "../assets/asset.rkt"
         "utils.rkt")
(provide (all-defined-out))

(define (how-sema-works)
  (pslide #:title "How to use Sema"
          #:layout 'center
          (code-block "ProcessCodeCompleteResults(Sema &S, CodeCompletionContext Context,"
                      "                           CodeCompletionResult *InResults, unsigned NumResults")
          (code-block "Context.getPreferedType()")
          (t "isNull(): no constraints based on types")
          (repl-input "f█")
          (t "!isNull(): there is a preferred type for candidates")
          (repl-input "strlen(█")
          (code-block "Context.getKind()")
          (item "CCC_TopLevelOrExpression")
          (item "CCC_DotMemberAccess")
          (repl-input "apple1.█")
          (code-block "Context.getBaseType()")
          (t "Apple")))

(module+ main
  (how-sema-works))
