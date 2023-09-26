#lang slideshow
(require ppict/slideshow2
         pict/code
         "utils.rkt")
(provide (all-defined-out))

(define (tab-event)
  (define fst (cc-superimpose
                (filled-rounded-rectangle 50 50 #:color "purple")
                (text "Tab")))
  (define snd (cc-superimpose
                           (filled-rounded-rectangle 100 50 #:color "purple")
                           (text "ReplListCompleter")))
  (define combined (hc-append 100 fst snd))
  (pslide #:layout 'center
          (parameterize ([get-current-code-font-size (lambda () (- (current-font-size) 10))])
            (repl-input "struct WhateverMeaningfulLoooooooooongName { int field;};"
                        "Wh⇥"))
          (pin-arrow-line 10
                          combined
                          fst rc-find
                          snd lc-find
                          #:line-width 3)))

(module+ main
  (tab-event))
