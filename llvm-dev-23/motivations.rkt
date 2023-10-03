#lang slideshow
(require ppict/slideshow2
         "utils.rkt")
(provide (all-defined-out))

(define (avoid-tedious-typing)
  (slide #:title "avoid tedious typing"))

(define (semantic-completion)
  (slide #:title "hello"))


(define (motivations)
  (for ([i (list "Wh⇥" "WhateverMeaningfulLoooooooooongName" "WhateverMeaningfulLoooooooooongName")]
        [j (list "getApple(f⇥" "getApple(f⇥" "getApple(fruitIsApple")])
    (pslide #:title "Motivations"
            (item "Avoid Tedious Typing")
            (repl-input "struct WhateverMeaningfulLoooooooooongName{ int field;};"
                        i)
            (item "Semantic Completion")
            (repl-input "struct Apple{ int price;};"
                        "struct Banana{ int StoreID;};"
                        "void getApple(Apple &a) {};"
                        "Apple fruitIsApple(10);"
                        "Banana fruitIsBanana(42);"
                        j))))
(module+ main
  (motivations))
