#lang slideshow
(require ppict/2
         "utils.rkt")
(provide (all-defined-out))

(define (demo)
  (for ([i (list "Mo⇥" "ModulePointerAndOffsetLessThanFunctionObject")])
    (pslide #:title "Basic Code Completion"
            #:comments ("When LLVM 18 is released, you will be able to complete a rather long class name when you want to use it to create an instance. As in this example, you have the class from lldb called ModulePointerAndOffsetLessThanFunctionObject. You can simply type Mo and hit tab and then you get the rest completed. ")
            #:go (coord 0.15 0.4 'lt)
            (repl-input #:font-size 25 "class ModulePointerAndOffsetLessThanFunctionObject{ ... };"
                        i)))

  (for ([j (list "pickOne(number1, ⇥" (list "pickOne(number1, █" "number1" "number2"))])
    (pslide #:title "Semantic Code Completion"
            #:comments ("In the near feature, you will have more precise completion results. Here, we have two numbers, and two strings. and a template function, called pickOne. Since pickOne's two arguments need to be of the same type. and we alrealy used number1 at this callsite, if we hit tab, the complete system shows number1 and number2")
            #:go (coord 0.15 0.4 'lt)
            (repl-input/with-output #:font-size 25
                                    "int number1 = 42, number2 = 84;"
                                    "std::string name1 = \"Fred\", name2 = \"Vassil\";"
                                    "template <typename T> T pickOne(T v1, T v2) {...};"
                                    j))))
(module+ main
  ;; (slide #:title "hello"
  ;;        (t "hello")
  ;;        (comment "this is a comment"))
  ;; (slide #:title "hello2"
  ;;        (t "hello2")
  ;;        (comment "this is a comment2"))
  (demo))
