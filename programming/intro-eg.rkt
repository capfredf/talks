; start: declaration
#lang racket/base ; ignore
(define (square x) (* x x)) ; ignore
(define-values (prop:norm norm? norm-accessor)
  (make-struct-type-property 'prop:norm))

(struct point2d (x y)
  #:property prop:norm
  (lambda (this)
    (sqrt (+ (square (point2d-x this))
             (square (point2d-y this))))))
;; ---sep--- initialization
(define pt-a (point2d 3 4))
;; ---sep--- extraction
(define m (norm-accessor pt-a))
;; ---sep--- application
(m pt-a)
;; result: 5
