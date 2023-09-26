(define-values (prop:norm norm? norm-accessor)
  (make-struct-type-property 'prop:norm))

(struct point2d (x y)
  #:property prop:norm
  (lambda (this)
    (sqrt (+ 9
             16))))
