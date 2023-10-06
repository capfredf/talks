#lang slideshow
(require ppict/2
         racket/splicing
         pict/code
         (prefix-in mp: metapict)
         "../assets/asset.rkt"
         "utils.rkt")
(provide (all-defined-out))

(define (what-is-clang-repl)
  (pslide #:title "What is ClangRepl?"
          (item "ClangRepl is a C++ interpreter inspired by Cling.")
          (item "It feature a REPL that let C++ programmers develop software in an exploratory manner")
          (repl-input/with-output "#include <iostream>"
                                  "std::string str = \"Hello, World!\";"
                                  (list "std::cout << str << \" has \" << str.length() << \"characters!\\n\";"
                                        "Hello, World! has 13 characters!")
                                  "█")))

(module+ main
  (what-is-clang-repl))
