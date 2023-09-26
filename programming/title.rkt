#lang slideshow
(require "utils.rkt"
         racket/runtime-path)
(define-runtime-path iu-logo "iu-logo.png")
(define-runtime-path rkt-logo "racket-logo.png")

(provide title)

(define (title)
  (center-title-slide "Type Checking Extracted Methods"
                      (+ (current-font-size) 20)
                      #:go (pp:coord 1/4 3/5 'lc)
                      (bt "Yuquan (Fred) Fu")
                      (bt "Sam Tobin-Hochstadt")
                      #:go (pp:coord 0.55 3/5 'lc)
                      (scale (bitmap rkt-logo) 0.2)
                      #:go (pp:coord 0.7 3/5 'lc)
                      (scale (bitmap iu-logo) 0.5)))


(module+ main
  (title))
