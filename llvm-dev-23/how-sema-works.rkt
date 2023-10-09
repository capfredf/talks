#lang slideshow
(require ppict/2
         racket/splicing
         pict/code
         (prefix-in mp: metapict)
         "../assets/asset.rkt"
         "utils.rkt")
(provide (all-defined-out))

(define (annotate p1 anno)
  (ht-append p1 anno))
(define (how-sema-works)
  (pslide #:title "Key Structure for Sematic Code Completion"
          #:go (coord 0.15 0.15 'lt)
          (current-gap-size)
          (tt "CodeCompletionContext")
          (item (t "Context.getKind() tells us the context kind"))
          (annotate (repl-input "c█") (code-block "<==== CCC_TopLevelOrExpression"))
          (annotate (repl-input "car.█") (code-block "<===== CCC_DotMemberAccess"))
          (item (t "Context.getPreferedType() tells us the type w.r.t the current cursor position"))
          (annotate (repl-input "pickOne(name1, █)") (code-block "<====== std::string")))
  (pslide #:title "Key Structure for Sematic Code Completion"
          (item (t "Context.getBaseType() gets us the type of the expressions before the dot"))
          (repl-input/with-output "class Car {public: int getPrice(){...} void sell(Person& p){...}}"
                                  "Car car1"
                                  (list "car1.⇥" "getPrice" "sell"))))

(module+ main
  (how-sema-works))
