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
          #:go (coord 0.1 0.1 'lt)
          (code-block "ProcessCodeCompleteResults(Sema &S, CodeCompletionContext Context,"
                      "                           CodeCompletionResult *InResults, unsigned NumResults)")
          (item (code-block "Context.getKind() == CCC_TopLevelOrExpression"))
          (subitem (code-block "Context.getPreferedType().isNull()"))
          #:go (coord 0.15 0.3 'lt)
          5
          (text "no constraints based on types" (current-main-font) (- (current-font-size) 5))
          (repl-input "f⇥")
          (code-block "foo"
                      "float")
          #:go (coord 0.1 0.52 'lt)
          (subitem (code-block "!Context.getPreferedType().isNull()"))
          #:go (coord 0.15 0.58 'lt)
          (text "there is a preferred type for candidates" (current-main-font) (- (current-font-size) 5))
          (repl-input "strlen(⇥")
          (code-block "cstr1"
                      "cstr2"))
  (pslide #:title "How to use Sema"
          #:go (coord 0.1 0.1 'lt)
          (code-block "ProcessCodeCompleteResults(Sema &S, CodeCompletionContext Context,"
                      "                           CodeCompletionResult *InResults, unsigned NumResults)")
          (item (code-block "Context.getKind() == CCC_DotMemberAccess"))
          (subitem (code-block "Context.getBaseType() => Apple"))
          #:go (coord 0.15 0.3 'lt)
          (repl-input "class Apple {public: int getPrice(){...} void sell(Person& p){...}}"
                      "Apple apple1"
                      "apple1.⇥")
          (code-block "getPrice"
                      "sell")))

(module+ main
  (how-sema-works))
