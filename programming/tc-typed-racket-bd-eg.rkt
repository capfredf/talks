; start: declaration
#lang typed/racket ;; ignore
(define (square [x : Integer]) : Integer ; ignore
  (* x x)) ; ignore
(: prop:norm (Struct-Property (-> Self Number)))
(: norm? (-> Any Boolean : (Has-Struct-Property prop:norm)))
(: norm-accessor (-> (Has-Struct-Property prop:norm)
                     (Some (X) (-> X Number) : X)))
(define-values (prop:norm norm? norm-accessor)
  (make-struct-type-property 'prop:norm))
(struct point2d ([x : Integer] [y : Integer])
  #:property prop:norm
  (lambda ([this : point2d]) : Number ...))
(struct point3d point2d ([z : Integer])
  #:property prop:norm
  (lambda ([this : point2d]) : Number ...))
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
