#lang racket
(require ppict/slideshow2
         slideshow/base
         pict/code)

(provide (all-defined-out))

(define prompt "clang-repl> ")
(define (code-block #:font-size [font-size (- (current-font-size) 10)] . lines)
  (parameterize ([get-current-code-font-size (lambda () font-size)])
    (codeblock-pict (string-join lines "\n"))))

(define (repl-input #:font-size [font-size (- (current-font-size) 10)] . lines)
  (apply code-block (map (lambda (n)
                           (string-append prompt n))
                         lines)
         #:font-size font-size))

(define-syntax-rule (define-sequence-nodes seq-id (node constr) ...)
  (begin
    (define node constr) ...
    (define seq-id (list node ...))))
