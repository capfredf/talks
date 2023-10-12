#lang slideshow
(require ppict/2
         "utils.rkt")
(provide (all-defined-out))

(define (demo)
  (for ([i (list "Mo⇥" "ModulePointerAndOffsetLessThanFunctionObject")])
    (pslide #:title "Basic Code Completion"
            #:go (coord 0.15 0.4 'lt)
            (repl-input #:font-size 25 "struct ModulePointerAndOffsetLessThanFunctionObject{ ... };"
                        i)))

  (for ([j (list "pickOne(number1, ⇥" (list "pickOne(number1, █" "number1" "number2"))])
    (pslide #:title "Semantic Code Completion"
            #:go (coord 0.15 0.4 'lt)
            (repl-input/with-output #:font-size 25
                                    "int number1 = 42, number2 = 84;"
                                    "std::string name1 = \"Fred\", name2 = \"Vassil\";"
                                    "template <typename T> T pickOne(T v1, T v2) {...};"
                                    j))))
(module+ main
  (demo))
