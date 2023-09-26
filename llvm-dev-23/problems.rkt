#lang slideshow
(require ppict/slideshow2
         pict/code)
(provide (all-defined-out))

(define (avoid-tedious-typing)
  (slide #:title "avoid tedious typing"))

(define (semantic-completion)
  (slide #:title "hello"))

(define prompt "clang-repl> ")
(define (repl-input . lines)
  (codeblock-pict (string-join (map (lambda (n)
                                      (string-append prompt n))
                                    lines)
                               "\n")))

(define (problems)
  (pslide #:title "Problems"
          #:next
          (item "Avoid Tedious Typing")
          (parameterize ([get-current-code-font-size (lambda () (- (current-font-size) 10))])
            (repl-input "struct WhateverMeaningfulLoooooooooongName{ int field;};"
                        "Wh<tab>"))
          #:next
          (item "Semantic Completion")
          (parameterize ([get-current-code-font-size (lambda () (- (current-font-size) 10))])
            (repl-input "struct Apple{ int price;};"
                        "struct Banana{ int StoreID;};"
                        "void getApple(Apple &a) {};"
                        "Apple fruitIsApple(10);"
                        "Banana fruitIsBanana(42);"
                        "getApple(f<tab>"))))
(module+ main
  (problems))
