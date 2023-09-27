#lang slideshow
(require ppict/2
         pict/code
         (prefix-in mp: metapict)
         "utils.rkt")
(provide (all-defined-out))

(define (tab-event)
  (mp:current-inner-separation 0.2)
  (define line-editor-node (mp:rounded-rectangle-node "Line Editor Node" #:color "purple"))
  (define completer-node (mp:rounded-rectangle-node "ReplListCompleter" #:color "purple" #:below line-editor-node))
  (define operator (mp:rounded-rectangle-node
                    "operator()(StringRef Buffer, size_t Pos)"
                    #:color "purple" #:below completer-node))
  (define tenode (mp:rounded-rectangle-node "tab event" #:color "purple" #:left-of operator))
  (define meat-node (mp:rectangle-node "THE MEAT" #:color "red" #:below operator))
  (define results (mp:rounded-rectangle-node "Results" #:color "purple" #:below tenode))

  (define e0 (mp:edge completer-node line-editor-node))
  (define e1 (mp:edge tenode operator))
  (define e2 (mp:edge completer-node operator))
  (define e3 (mp:edge operator meat-node))
  (define e4 (mp:edge meat-node results))
  (pslide #:go (coord 0.5 0.4 'cb)
          (parameterize ([get-current-code-font-size (lambda () (- (current-font-size) 10))])
            (repl-input "struct WhateverMeaningfulLoooooooooongName { int field;};"
                        "Wh⇥"))
          (mp:draw line-editor-node tenode completer-node operator meat-node results e0 e1 e2 e3 e4)))

(module+ main
  (tab-event))
