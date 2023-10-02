#lang slideshow
(require ppict/slideshow2
         "utils.rkt")
(provide (all-defined-out))

(define (avoid-tedious-typing)
  (slide #:title "avoid tedious typing"))

(define (semantic-completion)
  (slide #:title "hello"))


(define (motivations)
  (pslide #:title "Motivations"
          #:next
          (item "Avoid Tedious Typing")
          (repl-input "struct WhateverMeaningfulLoooooooooongName{ int field;};"
                      "Wh<tab>")
          #:next
          (item "Semantic Completion")
          (repl-input "struct Apple{ int price;};"
                      "struct Banana{ int StoreID;};"
                      "void getApple(Apple &a) {};"
                      "Apple fruitIsApple(10);"
                      "Banana fruitIsBanana(42);"
                      "getApple(f<tab>")))
(module+ main
  (motivations))
