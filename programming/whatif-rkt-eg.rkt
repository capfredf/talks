#lang racket/base ; ignore
(define (square x) (* x x)) ; ignore
(define-values (prop:norm norm? norm-accessor) ; ignore
  (make-struct-type-property 'prop:norm)) ; ignore
; ignore
(struct point2d (x y)
  #:property prop:norm
  (lambda (this)
    (sqrt (+ (square (point2d-x this))
             (square (point2d-y this))))))
; ---sep---
(define pt-a (point2d 3 4))
(define m (norm-accessor pt-a))
; ---sep---
(m 42)
; error: contract violation
