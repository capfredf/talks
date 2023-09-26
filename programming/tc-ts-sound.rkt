#lang slideshow
(require "utils.rkt" racket/runtime-path
         pict/face
         pict/code)


(define-runtime-path tc-ts-eg "tc-ts-sound.ts")
;; (define-runtime-path tc-ts-eg-sub "tc-ts-eg-sub.ts")

(provide tc-ts-sound)
(define (tc-ts-sound)
  (define code-font-size (+ ((get-current-code-font-size)) 10))
  (define-values (egs lh _) (read-code tc-ts-eg #:font-size code-font-size))

  (define e1 (list-ref egs 4))
  (transition-slide #:title (string-append (cap "Method Extraction") " in TypeScript")
                    (coord 0.2 0.15 'lt)
                    (list (list-ref egs 0)
                          (blank code-font-size)
                          (list-ref egs 1)
                          (list-ref egs 2)
                          (list-ref egs 3)
                          e1)
                    lh
                    (list)
                    (make-transitions 4 (make-code-pointer))
                    (make-transitions 5 (make-code-pointer))))

(module+ main
  (tc-ts-sound))
