#lang slideshow
(require pict "utils.rkt" racket/runtime-path)

(provide whatif-java)

(define-runtime-path whatif-java-eg "whatif.java")
(define (whatif-java)
  (transition-slide-from-file* #:title (cap "2. Dynamically Checking")
                               (coord 0.5 0.5 'cc)
                               whatif-java-eg
                               15))

(module+ main
  (whatif-java))
