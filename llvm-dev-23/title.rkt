#lang slideshow
(require "../lib/lib.rkt")
(require "../assets/asset.rkt")
(provide main-title)

(define (main-title)
  (main-title-slide #:title "Code Completion in ClangRepl"
                    #:authors
                    ["Yuquan (Fred) Fu" "Vassil Vassilev"]
                    #:logos
                    [(iu-logo) (compiler-research-team-logo 0.046)]
                    ;; Logos
                    ;; GSoC
                    ;; IU
                    ;; LLVM
                    ;; #:go (pp:coord 0.55 3/5 'lc)
                    ;; (scale (bitmap rkt-logo) 0.2)
                    ;; #:go (pp:coord 0.7 3/5 'lc)
                    ;; (scale (bitmap iu-logo) 0.5)
                    ))

(module+ main
  (main-title))
