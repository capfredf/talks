#lang racket
(require ppict/slideshow2
         slideshow/base
         pict/code)

(provide (all-defined-out))

(define prompt "clang-repl> ")
(define (repl-input #:fontsize [font-size (- (current-font-size) 10)] . lines)
  (parameterize ([get-current-code-font-size (lambda () font-size)])
    (codeblock-pict (string-join (map (lambda (n)
                                        (string-append prompt n))
                                      lines)
                                 "\n"))))
