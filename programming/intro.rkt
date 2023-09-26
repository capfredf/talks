#lang slideshow
(require "utils.rkt" pict/code)
(require racket/runtime-path)

(define-runtime-path curdir "./")

(define-syntax-rule (define-intro func-name file-name title)
  (begin
    (provide func-name)
    (define (func-name)
      (parameterize ([layout (hash 'declaration 9
                                   'initialization 1
                                   'extraction 2
                                   'application 10)])
        (transition-slide-from-file* #:title
                                     (string-append title " Example")
                                     (coord 0.05 0.13 'lt)
                                     (build-path curdir file-name))))))

(define-intro intro-js "intro.js" "JavaScript")
(define-intro intro-py "intro.py" "Python")
(define-intro intro-java "Point2D.java" "Java")


(provide intro-rkt)
(define (intro-rkt)
  (define code-font-size (+ ((get-current-code-font-size)) 8))
  (match-define-values ((list sub1) _ _) (read-code (build-path curdir "intro-eg-sub.rkt") #:font-size code-font-size))
  (match-define-values ((list sub2) _ _) (read-code (build-path curdir "intro-eg-sub2.rkt") #:font-size code-font-size))
  (match-define-values ((list sub3) _ _) (read-code (build-path curdir "intro-eg-sub3.rkt") #:font-size code-font-size))
  (parameterize ([layout (hash 'declaration 9
                               'initialization 1
                               'extraction 2
                               'application 10)])
        (transition-slide-from-file* #:title
                                     "Racket Example"
                                     (coord 0.05 0.13 'lt)
                                     (build-path curdir "intro-eg.rkt")
                                     8
                                     (make-transitions 0 (make-code-pointer 0 0 2 48)
                                                       0 (lambda (pic)
                                                           (ht-append pic (blank 50) (colorize (bt "VTable" 50) "crimson")))
                                                       0 (make-code-pointer 5 1 3 45))
                                     (make-transitions 1 (make-code-pointer))
                                     (make-transitions 2 (make-code-pointer))
                                     (make-transitions 3 (make-code-pointer))
                                     (make-transitions 0 (make-code-pointer 6 10 2 32)
                                                       0 sub1)
                                     (make-transitions 0 (make-code-pointer 6 10 2 20)
                                                       0 sub2)
                                     (make-transitions 0 (make-code-pointer 6 10 2 10)
                                                       0 sub3)
                                     (make-transitions 3 (make-code-pointer 1 0 1 10)))))

(module+ main
  ;; (intro-js)
  ;; (intro-py)
  ;; (intro-java)
  (intro-rkt))
