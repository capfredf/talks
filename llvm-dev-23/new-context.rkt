#lang slideshow
(require ppict/2
         racket/splicing
         racket/draw
         pict/code
         (prefix-in mp: metapict)
         "../assets/asset.rkt"
         "utils.rkt")
(provide (all-defined-out))

(define (new-context)
  (pslide #:title "Code Completion for Top Level Expressions"
          #:comments ("The other challenge we faced is Code Completion for Top Level Expressions"
                      "The challenge really comes down to the fact: Top level expressions are syntactically invalid in a regular C++ file"
                      "whereas Top level expressions are bread and butter in REPL"
                      "As shown in the example here, the completion system fails to provide num as a candidate in the beginning because the completion context is TOP level and any identifiers are hidden"
                      "The solution is straightforward. We simply added new completion context kind")
          #:layout 'tall
          (item "Top level expressions are syntactically invalid in a regular C++ file")
          (item "Top level expressions are bread and butter in REPL")
          #:go (coord 0.3 0.3 'lt)
          #:alt [(repl-input "int num = 42;"
                             "1 + n⇥ ")]
          (repl-input "int num = 42;"
                             "1 + n█ ")
          ;; #:go (at-find-pict 'repl lb-find 'lb #:abs-x 150)
          ;; (rectangle 200 30 #:border-color "red" #:border-width 4)
          #:next
          ;; #:go (coord 0.4 0.7 'lt)
          #:alt [(text "CompletionContext::Kind = CCC_TopLevel" (list (make-object color% "red")) 20)]
          (text "CompletionContext::Kind = CCC_TopLevelOrExpression" (list (make-object color% "dark green")) 20))

  (pslide #:title "Code Completion for Top Level Expressions"
          #:comments ("Now if we hit tab again, the rest of num gets completed.")
          #:layout 'tall
          (item "Top level expressions are syntactically invalid in a regular C++ file")
          (item "Top level expressions are bread and butter in REPL")
          #:go (coord 0.3 0.3 'lt)
          #:alt [(repl-input "int num = 42;"
                             "1 + n⇥ ")
                 (text "CompletionContext::Kind = CCC_TopLevelOrExpression" (list (make-object color% "dark green")) 20)]
          (repl-input "int num = 42;"
                      "1 + num ")
          (text "CompletionContext::Kind = CCC_TopLevelOrExpression" (list (make-object color% "dark green")) 20)))


(module+ main
  (new-context))
