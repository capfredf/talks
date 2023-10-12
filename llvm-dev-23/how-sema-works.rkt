#lang slideshow
(require ppict/2
         racket/splicing
         pict/code
         (prefix-in mp: metapict)
         "../assets/asset.rkt"
         "utils.rkt")
(provide (all-defined-out))

(define (annotate p1 anno)
  (pin-arrow-line 30 (ht-append 200 p1 anno)
                  anno lc-find
                  p1 rc-find
                  #:line-width 3
                  #:color "medium goldenrod"))
(define (how-sema-works)
  (pslide #:title "Key Structure for Sematic Code Completion"
          #:comments ("And the solution boils down to several structures used in Semantic modules. The most important one is CodeCompletionContext "
                      "Using its method getkind(), we are able to what kind of code completion we are doing. "
                      "with the type obtained from getPreferedType(), we can use it to filter or sort completion candidates. As in this case, name1 is a string, in the current contenxt, therefore the second argument also has to be a string ")
          #:go (coord 0.15 0.15 'lt)
          (current-gap-size)
          (tt "CodeCompletionContext")
          (item (t "::getKind() shows the context kind"))
          (annotate (repl-input "f█") (code-block "CCC_TopLevelOrExpression"))
          (annotate (repl-input "car.█") (code-block "CCC_DotMemberAccess"))
          (item (t "::getPreferedType() reveals the type w.r.t the current cursor position"))
          (annotate (repl-input "pickOne(name1, █") (code-block "std::string")))
  (pslide #:title "Key Structure for Sematic Code Completion"
          #:comments ("furthermore, we can use the method getBaseType to get the type of the expressions before the dot. Like in this case once we know the variable before the dot is a Car instance, it is quite easy to list all its public members")
          (item (t "CodeCompletionContext::getBaseType() returns the type of the expressions before the dot"))
          (repl-input/with-output "class Car {public: int getPrice(){...} void sell(Person& p){...}}"
                                  "Car car1"
                                  (list "car1.⇥" "getPrice" "sell"))))

(module+ main
  (how-sema-works))
