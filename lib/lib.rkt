#lang racket/base
(require slideshow
         pict/code
         pict/face
         ppict/slideshow2
         (rename-in ppict/2 [coord pp:coord]
                    [placer? pp:placer?])
         racket/class
         racket/contract
         racket/draw
         racket/runtime-path
         (for-syntax syntax/parse racket/base)
         pict/flash)
(provide (all-defined-out)
         pp:coord)

(define-syntax-rule (main-title-slide #:title title #:authors (authors ...) #:logos (elt ...))
  (center-slide
   #:title
   title
   #:go (pp:coord 1/4 3/5 'lc)
   (bt authors) ...
   #:go (pp:coord 0.55 0.55 'lt #:compose (lambda (_ . picts)
                                            (apply ht-append 30 picts)))
   elt ...))


(define-syntax-rule (center-slide #:title title elts ...)
  (pslide
   #:go (pp:coord 1/2 2/5 'cc)
   (para #:align 'center (parameterize ([current-font-size (+ (current-font-size) 20)])
                           (bt title)))
   elts ...))


(define-syntax-rule (title-only-slide #:title title elts ...)
  (parameterize ([current-font-size (+ (current-font-size) 80)])
    (center-slide #:title title elts ...)))
