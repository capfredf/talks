; start: declaration
#lang typed/racket ;; ignore
(define (square [x : Integer]) : Integer ; ignore
  (* x x)) ; ignore
(define definition-of-property-norm ......)
(struct point2d ([x : Integer] [y : Integer])
  #:property prop:norm
  (lambda ([this : point2d]) : Number
    (sqrt (+ (square (point2d-x this))
             (square (point2d-y this))))))
(struct point3d point2d ([z : Integer])
  #:property prop:norm
  (lambda ([this : point2d]) : Number
    (sqrt (+ (square (point2d-x this))
             (square (point2d-y this))
             (square (point2d-z this))))))
; ---sep--- initialization
(define pt-a (point2d 3 4))
(define pt-b : point2d (point3d 5 12))
; ---sep--- extraction
(define m (norm-accessor pt-b))
; ---sep--- application
;; (m 42) Type Error
;; (m pt-a) Type Error
(m pt-b)
;; result: 13
