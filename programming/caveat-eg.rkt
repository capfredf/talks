#lang typed/racket ;; ignore
;; pt-a : (Has-Struct-Property prop:norm)
;; pt-b : (Has-Struct-Property prop:norm)
;; assume m can take any value of the same type of pt-b
(define m (norm-accessor pt-b))
(m pt-a)
;; pt-b is actually a point3d
;; pt-a is actually a point2d
;; error: contract violation
