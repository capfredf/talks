#lang slideshow

(require ppict/slideshow2 "utils.rkt" racket/runtime-path)

(provide also-in-paper)

(define-runtime-path package-file "packages.png")

(define (also-in-paper)
  (pslide
   #:go (pp:coord 0.3 0.06 'rt)
   (scale (t "⊢") 8)
   #:go (pp:coord 0.35 0.2 'lt)
   (item "A formal model and a soundness proof")
   20
   #:go (pp:coord 0.35 0.4 'rt)
   (scale (bitmap package-file) 0.8)
   #:go (pp:coord 0.35 0.4 'lt)
   (item "Evaluation")
   10
   #:go (pp:coord 0.36 0.5 'lt)
   (item "164 packages depended on Typed Racket" #:bullet (blank))
   (item "40 of them had use of structure type properties" #:bullet (blank))
   (item "  This feature had not been type-checked" #:bullet (blank 30))
   (item "38 worked correctly" #:bullet (blank))
   (item "2 failed to type-check" #:bullet (blank))
   (item "  one missing annotations" #:bullet (blank 30))
   (item "  one having an easy-to-fix bug" #:bullet (blank 30))))

(module+ main
  (also-in-paper))
