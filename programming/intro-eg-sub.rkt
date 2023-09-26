(define-values (prop:norm norm? norm-accessor)
  (make-struct-type-property 'prop:norm))

(struct point2d (x y)
  #:property prop:norm
  (lambda (this)
    (sqrt (+ (square (point2d-x pt-a))
             (square (point2d-y pt-a))))))
