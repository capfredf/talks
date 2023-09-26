#lang slideshow

(require "../lib/lib.rkt")
(require "title.rkt")
(require "problems.rkt")
(require "tab-event.rkt")

(module+ main
  (main-title)
  (title-only-slide #:title "Problems")
  (problems)
  (title-only-slide #:title "Implementation")
  (tab-event))
