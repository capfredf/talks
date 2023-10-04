#lang racket
(require ppict/slideshow2
         slideshow/base
         (prefix-in mp: metapict)
         pict/code)

(provide (all-defined-out))

(define prompt "clang-repl> ")
(define (code-block #:font-size [font-size (- (current-font-size) 10)] . lines)
  (parameterize ([get-current-code-font-size (lambda () font-size)]
                 [current-token-class->color token-class-color])
    (codeblock-pict (string-join lines "\n"))))

(define (token-class-color s)
  "black")

(define (repl-input #:font-size [font-size (- (current-font-size) 10)] . lines)
  (apply code-block (map (lambda (n)
                           (string-append prompt n))
                         lines)
         #:font-size font-size))

(define-syntax-rule (define-sequence-nodes seq-id (node constr) ...)
  (begin
    (define node constr) ...
    (define seq-id (list node ...))))

(define (get-code-completion-at input)
  (match-define (cons hd tl) (string-split input "⇥"))
  (string-length hd))

(define-syntax-rule (my-job-node params ...)
  (let ()
    (define font (mp:make-similar-font (mp:new-font)
                                       #:size 10))
    (mp:rectangle-node params ... #:fill "orange")))
