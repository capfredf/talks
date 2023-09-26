#lang slideshow
(require "utils.rkt" racket/runtime-path pict/code)

(define-runtime-path norm-file "normp.rkt")
(provide occ+ext)
(define (occ+ext)
  (define _t (lambda (x) (text x null 18)))
  (define-values (tbl-x tbl-y) (values 300 0))
  (define before-env (make-env-table (list (_t "val : (U String (Has-Struct-Property prop:norm))")) 500))
  (define after-env1 (make-env-table (list (_t "val : (Has-Struct-Property prop:norm)")) 500))
  (define after-env2 (make-env-table (list (_t "val : String")) 500))
  (define (refresh1 pic)
    (pin-over pic tbl-x tbl-y (filled-rectangle (pict-width before-env)
                                                (pict-width before-env)
                                                #:draw-border? #f
                                                #:color "white")))

  (define slide-title "Occurrence Typing + Existential Types")

  (define (scene1)
    (transition-slide-from-file* #:title slide-title
                                 (coord 0.2 0.10 'lt)
                                 norm-file
                                 8
                                 (make-transitions 0 (make-code-pointer))
                                 (make-transitions 1 (make-code-pointer))
                                 (make-transitions 2 (make-code-pointer 0 0 +inf.0)
                                                   2 (lambda (pic)
                                                       (pin-over pic tbl-x tbl-y
                                                                 before-env)))
                                 (make-transitions 2 (make-code-pointer 0 4 1 11))
                                 (make-transitions 2 (make-code-pointer 1 4 1 3)
                                                   0 (make-code-pointer 0 28 1 31)
                                                   2 (lambda (pic)
                                                       (let ([p (refresh1 pic)])
                                                         (pin-over pic tbl-x tbl-y after-env1))))
                                 (make-transitions 2 (make-code-pointer 2 4 1 3)
                                                   2 (lambda (pic)
                                                       (let ([p (refresh1 pic)])
                                                         (pin-over pic tbl-x tbl-y after-env2))))))

  (define (scene2)
    (define-values (tbl-x tbl-y) (values 500 50))
    (define before-env (make-env-table (list (_t "pt-a : point2d ")
                                         (_t "pt-b : point3d"))
                                       500))
    (define after-env (make-env-table
                       (list (_t "pt-a : point2d")
                             (htl-append (_t "pt-b : (∧  point3d  ")
                                         (colorize (_t "X)") "dark green"))
                             (colorize (_t "m : (-> X Number)")  "dark green"))
                       500))
    (define (refresh1 pic)
      (pin-over pic tbl-x tbl-y (filled-rectangle (pict-width before-env)
                                                  (pict-width before-env)
                                                  #:draw-border? #f
                                                  #:color "white")))
    (transition-slide-from-file* #:title slide-title
                                 (coord 0.2 0.10 'lt)
                                 norm-file
                                 8
                                 (make-transitions 4 (make-code-pointer 0 0 +inf.0))
                                 (make-transitions 4 (make-code-pointer 1 23 1 30))
                                 (make-transitions 4 (make-code-pointer 1 30 1 1)
                                                   4 (make-code-pointer 1 37 1 1)
                                                   4 (make-code-pointer 1 49 1 1))
                                 (make-transitions 4 (make-code-pointer 2 10 1 20)
                                                   4 (lambda (pic)
                                                       (pin-over pic tbl-x tbl-y before-env)))
                                 (make-transitions 4 (make-code-pointer 2 8 1 1)
                                                   4 (lambda (pic)
                                                       (let ([pic (refresh1 pic)])
                                                         (pin-over pic tbl-x tbl-y after-env))))
                                 (make-transitions 4 (make-code-pointer 3 0 2 35))
                                 (make-transitions 4 (make-code-pointer 5 0 2 20))
                                 (make-transitions 5 (make-code-pointer 0 0 1 35)
                                                   5 (lambda (pic)
                                                       (pin-over pic
                                                                 400 -10
                                                                  (scale (colorize (t "?") "dark red") 2))))))
  (scene1)
  (scene2))

(module+ main
  (occ+ext)
  #;
  (occ+ext))
