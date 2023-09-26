#lang slideshow
(require pict pict/code ppict/slideshow2 "utils.rkt" racket/runtime-path)

(provide whatif-python)

(define-runtime-path whatif-python-eg "whatif.py")
(define (whatif-python)
  (transition-slide-from-file* #:title (cap "1. The Receiver is Bound(Python)")
                               (coord 0.5 0.5 'cc)
                               whatif-python-eg
                               15))

(module+ main
  (whatif-python))
