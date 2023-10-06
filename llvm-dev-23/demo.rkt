#lang slideshow
(require ppict/2
         "utils.rkt")
(provide (all-defined-out))

(define (demo)
  (for ([i (list "Wh⇥" "WhateverMeaningfulLoooooooooongName")])
    (pslide #:title "Demo"
            #:go (coord 0.15 0.4 'lt)
            (item "Avoid Tedious Typing")
            #:go (coord 0.2 0.5 'lt)
            (repl-input "struct WhateverMeaningfulLoooooooooongName{ int field;};"
                        i)))

  (for ([j (list "pickOne(number1, ⇥" (list "pickOne(number1, █" "number1" "number2"))])
    (pslide #:title "Demo"
            #:go (coord 0.15 0.4 'lt)
            (item "Semantic Completion")
            #:go (coord 0.2 0.5 'lt)
            (repl-input/with-output "int number1 = 42, number2 = 84;"
                                    "std::string name1 = \"Fred\", name2 = \"Yuquan\";"
                                    "template <typename T> T pickOne(T v1, T v2) {...};"
                                    j))))
(module+ main
  (demo))
