#lang slideshow
(require "../lib/lib.rkt")
(require "../assets/asset.rkt")
(provide main-title)

(define (main-title)
  (center-slide
   #:title
   "Code Completion in Clang-Repl"
   #:comments ("Hi Everyone. I'm Fred Fu. "
               "Today, I'll be talking about Code Completion in Clang-Repl. "
               "This is a project of Google Summer of Code 2023 mentored by Vassil Vassilev. We are a member of compiler research team. I am also a PhD student at Indiana University")
   #:go (pp:coord 0.13 0.4 'lc)
   (gsoc-logo 0.05)
   #:go (pp:coord 1/4 0.5 'lt)
   (hc-append 50 (bt "Yuquan (Fred) Fu") (compiler-research-team-logo 0.046) (iu-logo))
   (hc-append 50 (bt "Vassil Vassilev    ") (compiler-research-team-logo 0.046))))

(module+ main
  (main-title))
