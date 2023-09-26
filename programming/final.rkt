#lang slideshow

(require ppict/2 (except-in "utils.rkt" placer? coord))

(provide final)

(define (final)
  (define header (list (bt "Unbound Method?") okay
                       (bt "No Runtime Check?") okay
                       (bt "Sound?") okay))
  (pslide #:title "Summary"
          (item "Extracted Methods in Typed Racket")
          (subitem "Occurence Typing + Existential Types")
          (table 2
                 header
                 lc-superimpose
                 lc-superimpose
                 10
                 10)
          (subitem "Our approach worked for 40 packages")
          (subitem "Shipping in Racket since version 8.2")
          (t "Thank you for watching!")))


(module+ main
  (final))
