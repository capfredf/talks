#lang slideshow
(require "../lib/lib.rkt")
(require "../assets/asset.rkt")
(provide main-title)

(define (main-title)
  (center-slide
   #:title
   "Code Completion in ClangRepl"
   #:go (pp:coord 1/7 0.4 'lc)
   (gsoc-logo 0.05)
   #:go (pp:coord 1/4 0.5 'lt)
   (hc-append 50 (bt "Yuquan (Fred) Fu") (compiler-research-team-logo 0.046) (iu-logo))
   (hc-append 50 (bt "Vassil Vassilev    ") (compiler-research-team-logo 0.046))))

(module+ main
  (main-title))
