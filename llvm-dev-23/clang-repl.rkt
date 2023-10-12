#lang slideshow
(require ppict/2
         racket/splicing
         pict/code
         (prefix-in mp: metapict)
         "../assets/asset.rkt"
         "utils.rkt")
(provide (all-defined-out))

(define (what-is-clang-repl)
  (pslide ;;
   ;; (item "ClangRepl is a C++ interpreter inspired by Cling.")
   ;; (item "It feature a REPL that let C++ programmers develop software in an exploratory manner")
   #:comments ("ClangRepl is fundamentally an interpreter built upon llvm
compiler pipeline, It allows C++ programmres to an exploratory manner. Like
here, we defined a string, and used it as a part of content we printed out to the
standand output.")
   (repl-input/with-output #:font-size 25
                           "#include <iostream>"
                           "std::string str = \"Hello, World!\";"
                           (list "std::cout << str << \" has \" << str.length() << \"characters!\\n\";"
                                 "Hello, World! has 13 characters!")
                           "█"))
  (pslide
   #:comments ("What if we want to list all the members of the variable with a single TAB in REPL? This is where code completion comes in handy!")
   (repl-input/with-output #:font-size 25
                           "#include <iostream>"
                           "std::string str = \"Hello, World!\";"
                           (list "std::cout << str << \" has \" << str.length() << \"characters!\\n\";"
                                 "Hello, World! has 13 characters!")
                           "str.⇥")
   #:next
   #:go (coord 0.245 0.605 'ct)
   (tag-pict (filled-rectangle 100 3 #:draw-border? #f #:color "red") 'line)
   #:go (coord 0.5 0.7 'cc)
   (tag-pict (t "My Project!") 'text)
   #:set (let ([p ppict-do-state])
           (pin-arrow-line 10 p
                           (find-tag p 'line) cb-find
                           (find-tag p 'text) lc-find
                           #:start-angle (- (* (/ pi 360) 190))
                           #:line-width 3
                           #:color "red"))))

(module+ main
  (what-is-clang-repl))
