#lang racket/base ; ignore
(define (square x) (* x x)) ; ignore
(define-values (prop:norm norm? norm-accessor) ; ignore
  (make-struct-type-property 'prop:norm)) ; ignore
; ignore
(struct point2d (x y)
  #:property prop:norm
  (lambda (this)
    (sqrt (+ (square (point2d-x 42))
             (square (point2d-y 42))))))
