#lang typed/racket ;; ignore
; norm? : (-> Any Boolean : (Has-Struct-Property prop:norm)))
;---sep---
; val : (U String (Has-Struct-Property prop:norm)))
;---sep---
(if (norm? val)
    val
    val)
;---sep---





;---sep---
; (: norm-accessor (-> (Has-Struct-Property prop:norm)
;                      (Some (X) (-> X Number) : X)))
(define m (norm-accessor pt-b))
; (m 42) Type Error
; (m pt-a) Type Error
(m pt-b)
; result: 13
;---sep---
; (m (point3d 5 6 7)) Type Error
