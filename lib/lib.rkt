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

(define-syntax-rule (center-title-slide #:title title #:authors (authors ...) #:logos (elt ...))
  (pslide
   #:go (pp:coord 1/2 2/5 'cc)
   (para #:align 'center (parameterize ([current-font-size (+ (current-font-size) 20)])
                           (bt title)))
   #:go (pp:coord 1/4 3/5 'lc)
   (bt authors) ...
   #:go (pp:coord 0.55 0.55 'lt #:compose (lambda (_ . picts)
                                            (apply ht-append 30 picts)))
   elt ...))

