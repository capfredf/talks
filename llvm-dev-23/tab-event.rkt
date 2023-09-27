#lang slideshow
(require ppict/2
         pict/code
         (prefix-in mp: metapict)
         "utils.rkt")
(provide (all-defined-out))

(define (tab-event)
  (mp:current-inner-separation 0.2)
  (define tenode (mp:rounded-rectangle-node "tab event" #:color "purple"))
  (define operator (mp:rounded-rectangle-node
                    "operator()(StringRef Buffer, size_t Pos)"
                    #:color "purple" #:right-of tenode))
  (define completer-node (mp:rounded-rectangle-node "ReplListCompleter" #:color "purple" #:above operator))

  (define e1 (mp:edge tenode operator))
  (define e2 (mp:edge completer-node operator))
  (pslide #:layout 'center
          (parameterize ([get-current-code-font-size (lambda () (- (current-font-size) 10))])
            (repl-input "struct WhateverMeaningfulLoooooooooongName { int field;};"
                        "Wh⇥"))
          #:go (coord 0.3 0.85 'cb)
          (mp:draw tenode completer-node operator e1 e2)))

(module+ main
  (tab-event))
