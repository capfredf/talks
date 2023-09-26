#lang slideshow
(require "utils.rkt" racket/runtime-path
         pict/code)


(define-runtime-path tc-flow-eg "tc-flow-unsound.js")
(define-runtime-path tc-flow-eg-sub "tc-flow-unsound-sub.js")
(define-runtime-path tc-flow-eg-sub2 "tc-flow-unsound-sub2.js")

(provide tc-flow-unsound)
(define (tc-flow-unsound)
  (define code-font-size (+ ((get-current-code-font-size)) 10))
  (define-values (egs lh _) (read-code tc-flow-eg #:font-size code-font-size))
  (match-define-values ((list sub) _ _) (read-code tc-flow-eg-sub #:font-size code-font-size))
  (match-define-values ((list sub2) _ _) (read-code tc-flow-eg-sub2 #:font-size code-font-size))

  (define e1 (list-ref egs 3))
  (define reg-pointer (make-code-pointer 0 0 +inf.0))
  (define sub-pointer (make-code-pointer 6 0 1))
  (transition-slide #:title (string-append (cap "Method Extraction") " in Flow")
                    (coord 0.2 0.15 'lt)
                    (list (list-ref egs 0)
                          (blank code-font-size)
                          (list-ref egs 1)
                          (list-ref egs 2)
                          e1)
                    lh
                    (list)
                    (make-transitions 0 reg-pointer)
                    (make-transitions 4 reg-pointer)
                    (make-transitions 0 sub-pointer
                                      0 sub)
                    (make-transitions 0 sub-pointer
                                      0 sub2)
                    (make-transitions 4 (make-code-pointer 1 0))))

(module+ main
  (tc-flow-unsound))
