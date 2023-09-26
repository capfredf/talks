#lang slideshow
(require ppict/slideshow2
         pict/code
         "utils.rkt")
(provide (all-defined-out))

(define (tab-event)
  (pslide #:layout 'center
          (parameterize ([get-current-code-font-size (lambda () (- (current-font-size) 10))])
            (repl-input "struct WhateverMeaningfulLoooooooooongName { int field;};"
                        "Wh⇥"))))

(module+ main
  (tab-event))
