#lang slideshow
(require "utils.rkt" racket/runtime-path
         racket/draw
         pict/code)

(define-runtime-path tc-tr-eg "tc-typed-racket-bd-eg.rkt")

(provide tc-tr-breakdown tc-tr-breakdown-part1)


(define dsize 5)

(define _t (lambda (x) (text x null 18)))

(define before-env (make-env-table (list (_t "pt-a : point2d ")
                                         (_t "pt-b : point3d"))
                                   500))
(define after-env (make-env-table
                   (list (_t "pt-a : point2d")
                         (htl-append (_t "pt-b : (∧  point3d  ")
                                     (colorize (_t "X)") "dark green"))
                         (colorize (_t "m : (-> X Number)")  "dark green"))
                   500))


(define (dim pic)
  (cellophane pic 0.3))

(define (tc-tr-breakdown-part1)
  (define-values (tbl-x tbl-y) (values 500 -50))
  (parameterize ([layout (hash 'declaration 10
                               'initialization 2
                               'extraction 2
                               'application 10)])
    (transition-slide-from-file*
     #:title (string-append (cap "Sound Method Extraction") " in Typed Racket")
     (coord 0.1 0.12 'lt)
     tc-tr-eg
     dsize
     (make-transitions 0 dim)
     (make-transitions 2 (make-code-pointer 0 10 1 20)
                       2 (lambda (pic)
                           (pin-over pic tbl-x tbl-y before-env)))
     ;; ;; highlight pt-a and its corresponding parameter type in norm-accessor
     ;; (make-transitions 2 (make-code-pointer 0 25 1 4))
     ;; hightight m and its corresponding part in the codomain of norm-accessor
     (make-transitions 2 (make-code-pointer 0 8 1 1)
                       2 (lambda (pic)
                           (pin-over pic tbl-x tbl-y after-env)))
     (make-transitions 3 (make-code-pointer))
     (make-transitions 3 (make-code-pointer 1 0))
     (make-transitions 3 (make-code-pointer 2 0)))))


(define (tc-tr-breakdown-part2)
  (define-values (tbl-x tbl-y) (values 500 -50))
  (define font-size (+ ((get-current-code-font-size)) dsize))
  (parameterize ([layout (hash 'declaration 10
                               'initialization 2
                               'extraction 2
                               'application 10)])
    (transition-slide-from-file*
     #:title (string-append (cap "Sound Method Extraction") " in Typed Racket")
     #:reorganizer (lambda (frame)
                     (map dim frame))
     (coord 0.1 0.12 'lt)
     tc-tr-eg
     dsize
     (make-transitions 0 (lambda (pic)
                           (define hl (/ (pict-height pic) 12))
                           (pin-over pic 0 (* 2 hl)
                                     (parameterize ([get-current-code-font-size (lambda ()
                                                                                  font-size)])
                                       (vl-append
                                        (codeblock-pict "(: norm-accessor (-> (Has-Struct-Property prop:norm)")
                                        (codeblock-pict "                     (Some (X) (-> X Number) : #:+ X)))")))))
                       0 (make-code-pointer 2 0 2))
     (make-transitions 0 (lambda (pic)
                           (define hl (/ (pict-height pic) 12))
                           (define font-size (+ ((get-current-code-font-size)) dsize))
                           (pin-over pic 0 (* 1 hl)
                                     (parameterize ([get-current-code-font-size (lambda ()
                                                                                  font-size)])
                                       (codeblock-pict "(: norm? (-> Any Boolean : (Has-Struct-Property prop:norm)))"))))
                       0 (make-code-pointer 1 0 3)))))

(define (tc-tr-breakdown)
  (tc-tr-breakdown-part1)
  (tc-tr-breakdown-part2))

(module+ main
  (tc-tr-breakdown-part1)
  (tc-tr-breakdown-part2))
