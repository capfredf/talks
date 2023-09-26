#lang slideshow
(require pict/code
         ;(except-in "beamer.rkt" title block)
         "title.rkt"
         "utils.rkt"
         "intro.rkt"
         "whatif-java.rkt"
         "whatif-python.rkt"
         "whatif-js.rkt"
         "whatif-rkt.rkt"
         "summerization.rkt"
         "tc-flow.rkt"
         "tc-ts-sound.rkt"
         "tc-typed-racket.rkt"
         "tc-typed-racket-breakdown.rkt"
         "tc-ts-unsound.rkt"
         "signpost.rkt"
         "motivation.rkt"
         "other.rkt"
         "occ+ext.rkt"
         "caveat.rkt"
         "final.rkt")

(module+ main

  (current-code-font "Inconsolata")
  ;(current-title-font "Quattrocento")
  ;(current-main-font "Cantarell")

  (title)
  (center-title-slide (cap "What are extracted methods?") (+ (current-font-size) 20))
  (signpost)
  (motivation)
  (center-title-slide (cap "Real world examples") (+ (current-font-size) 20))
  (intro-js)
  (intro-py)
  (intro-java)
  (intro-rkt)
  (center-title-slide (cap "What if an incorrect receiver is supplied?")
                      (+ (current-font-size) 10))
  (whatif-python)
  (whatif-java)
  (whatif-js)
  (whatif-rkt)
  (summarize-whatif)
  (center-title-slide (cap "With a static type checker")
                      (+ (current-font-size) 10))
  (tc-flow-unsound)
  (tc-ts-sound)
  (tc-ts-unsound)
  (summarize-typechecker)
  (tc-tr)
  (center-title-slide "Walkthrough"
                      (+ (current-font-size) 10))
  (tc-tr-breakdown)
  (occ+ext)
  (caveat)
  (center-title-slide "Also in the Paper"
                      (+ (current-font-size) 10))
  (also-in-paper)
  (final))
