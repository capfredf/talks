#lang racket/base
(require slideshow
         pict/code
         pict/face
         ppict/slideshow2
         (rename-in ppict/2 [coord pp:coord]
                    [placer? pp:placer?])
         racket/class
         racket/contract
         racket/draw
         racket/runtime-path
         (for-syntax syntax/parse racket/base)
         pict/flash)
(provide (all-defined-out)
         pp:coord)
(define coord list)
(define (placer? x)
  (match x
    [(list (? number?) (? number?) (? symbol?)) #t]
    [_ #f]))

(define (list-insert lst idx val)
  (define-values (before after) (split-at lst idx))
  (append before (list val) after))

(define cap string-titlecase)

(define-syntax-rule (center-title-slide title font-size elt ...)
  (pslide
   #:go (pp:coord 1/2 2/5 'cc)
   (para #:align 'center (parameterize ([current-font-size font-size])
                           (bt title 50)))
   elt ...))

(struct transition (idx action) #:transparent)

(define-syntax (make-transitions stx)
  (syntax-parse stx
    [(_ (~seq idx action) ...)
     #'(list (transition idx action) ...)]))

(struct frame-config [cc-width cc-height] #:transparent)

(struct code-pointer (at-col at-row n-rows n-cols) #:transparent)

(define (make-code-pointer (at-row 0) (at-col 0) (n-rows 1) (n-cols +inf.0))
  (code-pointer at-col at-row n-rows n-cols))

(define (make-label txt size)
  (colorize (hc-append
             (text txt null size))
            (make-object color% #x89 #x59 #xa8)))

(define/contract (generate-transition-seq base tss fr-cfg)
  (->* ((listof pict?) (listof (listof transition?)) frame-config?)
       (listof (listof pict?)))
  (define-values (pointers non-pointers)
    (for/lists (_1 _2) ([s (in-list tss)])
      (partition (lambda (a)
                   (code-pointer? (transition-action a)))
                 s)))

  (define seqs
    (for/fold ([acc (list base)]
               #:result (reverse acc))
              ([next (in-list non-pointers)])
      (cons (foldl (lambda (step res)
                     (match step
                       [(transition idx p)
                        (if (procedure? p)
                            (list-update res idx p)
                            (list-update res idx (lambda _ p)))]))
                   (car acc)
                   next)
            acc)))

  (cons base
        (for/list ([frame (cdr seqs)]
                   [a (in-list pointers)])
          (match a
            [(? null?)
             frame]
            [(list (transition idxes pters) ...)
             (for/fold ([frame frame])
                       ([idx idxes]
                        [pter pters])
               (list-update frame idx
                            (lambda (pic)
                              (pin-pointer pic
                                           (* (code-pointer-at-col pter)
                                              (frame-config-cc-width fr-cfg))
                                           (* (code-pointer-at-row pter)
                                              (frame-config-cc-height fr-cfg))
                                           (* (code-pointer-n-cols pter)
                                              (frame-config-cc-width fr-cfg))
                                           (* (code-pointer-n-rows pter)
                                              (frame-config-cc-height fr-cfg))))))]))))

(define/contract (transition-slide* #:title [title #f] init-coord base-frame fr-cfg tags [transitionss null])
  (->* (placer? (listof pict?) frame-config? (listof symbol?))
       (#:title (or/c #f string?) (listof (listof transition?)))
       void?)
  (apply transition-slide
         #:title title
         init-coord
         base-frame
         fr-cfg
         tags
         (if (empty? transitionss)
             (for/list ([(_ i) (in-indexed base-frame)])
               (make-transitions i (make-code-pointer 0 0 +inf.0)))
             transitionss)))

(define layout (make-parameter #f))

(define/contract (transition-slide-from-file* #:title [title #f] #:reorganizer [reorganizer (lambda (frame) frame)]
                                              init-coord file-name [dfont-size 8] . transitionss)
  (->* (placer? path-string?) (#:title (or/c #f string?) #:reorganizer (-> (listof pict?) (listof pict?)) number?)
       #:rest (listof (listof transition?))
       void?)
  (define-values (base-frame lh tags)
    (read-code file-name #:font-size (+ dfont-size ((get-current-code-font-size)))))

  (transition-slide* #:title title
                     init-coord
                     (reorganizer base-frame)
                     lh
                     tags
                     transitionss))

(define (make-set-op tags init-coord)
  (define font-size (+ ((get-current-code-font-size)) 10))
  (cond
    [(and (layout) (pair? tags))
     (define label-picts (map (lambda (x)
                                (define txt (string-upcase (symbol->string x)))
                                (make-label (string-append txt ":")
                                            font-size))
                              tags))
     (define max-length (pict-width (argmax pict-width label-picts)))
     (define lh (pict-height (car label-picts)))
     (define x-offset (* (get-client-w #:aspect 'widescreen) (first init-coord)))
     (lambda (state frame)
       (for/fold ([p state]
                  [curr-y (* (get-client-h #:aspect 'widescreen) (second init-coord))]
                  #:result p)
                 ([tag (in-list tags)]
                  [label-pict (in-list label-picts)]
                  [blk (in-list frame)])
         (define labeled-p (pin-over p x-offset curr-y label-pict))
         (values (pin-over labeled-p (+ max-length x-offset 15) (+ curr-y lh) blk)
                 (+ curr-y (* (add1 (hash-ref (layout) tag)) lh)))))]
    [(pair? tags)
     (lambda (state frame)
       (for/fold ([p (ppict-do state #:go (apply pp:coord init-coord)
                               (apply vl-append frame))])
                 ([tag (in-list tags)])
         (define txt (string-upcase (symbol->string tag)))
         (define-values (x y) (lt-find p (find-tag p tag)))
         (define label-pict (make-label (string-append txt ":")
                                        (+ ((get-current-code-font-size)) 10)))
         (pin-over p (- x (pict-width label-pict) 10) y label-pict)))]
    [else
     (lambda (state frame)
       (ppict-do state #:go (apply pp:coord init-coord)
                 (apply vl-append frame)))]))

(define/contract (transition-slide #:title [title #f] init-coord seq fr-cfg tags . next-sub)
  (->* (placer? (listof pict?) frame-config? (listof symbol?))
       (#:title (or/c #f string?)) #:rest (listof (listof transition?)) void?)
  (define frames (generate-transition-seq seq next-sub fr-cfg))
  (define set-op (make-set-op tags init-coord))

  (for ([f (in-list frames)])
    (if title
        (pslide #:title title
                #:set (set-op ppict-do-state f))
        (pslide #:set (set-op ppict-do-state f)))))

(struct eval-res (res err?) #:transparent)

(struct block (tag [content #:mutable]) #:transparent)

(define-runtime-path current-dir "./")

(define ((stage-blocks comment-token) in)
  (define starting-tag
    (let* ([expect-pragma (format "~a start:" comment-token)]
           [len (string-length expect-pragma)])
      (if (equal? (peek-string len 0 in) expect-pragma)
          (car (string-split (peek-string 15 len in)))
          "")))
  (define indent-adj #f)
  (define (maybe-change-indentation d)
    (cond
      [(not (string? d)) d]
      [(number? indent-adj)
       (define ind (make-string (* 2 (abs indent-adj)) #\space))
       (if (indent-adj . >= . 0)
           (string-append ind d)
           (string-trim d ind #:left? #t))]
      [else d]))
  (for/fold ([blocks (list (block starting-tag (list)))]
             [curr 0]
             [folding #f]
             #:result (begin (for-each (lambda (b)
                                         (set-block-content! b (reverse (block-content b))))
                                       blocks)
                             blocks))
            ([i (in-lines in)])

    (define (update-blocks data [op cons])
      (list-update blocks curr (lambda (b)
                                 (set-block-content! b (op (maybe-change-indentation data) (block-content b)))
                                 b)))


    (match i
      [(pregexp (format "~a\\s*start" comment-token)) #:when (not folding)
       (values blocks curr folding)]
      [(pregexp (format "~a\\s*ignore\\s*" comment-token)) #:when (not folding)
       (values blocks curr folding)]
      [(pregexp (format "~a\\s*fold starts:\\s*(.*)?\\s*$" comment-token) (list _ fn)) #:when (not folding)
       (values blocks curr fn)]
      [(pregexp (format "~a\\s*indent:\\s*(-?\\d+)\\s*$" comment-token) (list _ (app string->number d)))
       #:when (not folding)
       (set! indent-adj d)
       (values blocks curr folding)]
      [(pregexp (format "~a\\s*fold stops\\s*$" comment-token))
       (values (update-blocks (reverse
                               (string-split (port->string (open-input-file (build-path current-dir folding))) "~n"))
                              append) curr #f)]
      [(pregexp (format "~a\\s*---sep---\\s*(.*?)\\s*$" comment-token) (list o tag))
       #:when (not folding)
       (values (append blocks (list (block tag null)))
               (add1 curr)
               folding)]
      [(pregexp (format "~a\\s*result:\\s*(.*?)\\s*$" comment-token) (list _ res))
       #:when (not folding)
       (values (update-blocks (eval-res res #f)) curr folding)]
      [(pregexp (format "~a\\s*error:\\s*(.*?)\\s*$" comment-token) (list _ res))
       #:when (not folding)
       (values (update-blocks (eval-res res #t)) curr folding)]
      [_
       #:when (not folding)
       (values (update-blocks i) curr folding)]
      [_ (values blocks curr folding)])))

(define (read-code fn #:font-size [font-size #f])
  (->* (path-string?) (#:font-size (or/c #f number?))
       (values (listof pict?)
               (cons/c number? number?)
               (listof symbol?)))
  (define comment-token (match (path-get-extension fn)
                          [#".java" "//"]
                          [#".py" "#"]
                          [#".ts" "//"]
                          [#".rkt" ";"]
                          [#".js" "//"]))

  (define staged-blocks (call-with-input-file fn
                          (stage-blocks comment-token)))

  (define font-size-f (if font-size
                          (lambda ()
                            font-size)
                          (get-current-code-font-size)))

  (define width #f)
  (parameterize ([get-current-code-font-size font-size-f])
    (set! width (/ (pict-width (codeblock-pict "hello")) 5))
    (define res (map (lambda (n)
                       (define res (foldl (lambda (x acc)
                                            (match x
                                              ["" (vl-append acc (codeblock-pict " "))]
                                              [(? string? x)
                                               (vl-append acc
                                                          (codeblock-pict x))]
                                              [(eval-res res err?)
                                               (vl-append acc
                                                          (draw-eval-result res err?))]))
                                          (blank)
                                          (block-content n)))
                       (if (equal? (block-tag n) "")
                           res
                           (tag-pict res (string->symbol (block-tag n)))))
                     staged-blocks))

    (values res
            (frame-config width (/ (pict-height (car res))
                                   (length (block-content (car staged-blocks)))))
            (filter-map (lambda (x)
                          (define tag (block-tag x))
                          (and (not (equal? tag ""))
                               (string->symbol tag)))
                        staged-blocks))))

(define (draw-eval-result res [err? #f])
  (define res-pic (foldl hc-append (blank) (map (lambda (x)
                                                   (text x null ((get-current-code-font-size))))
                                                (string-split res "\n"))))
  (define out (if err?
                  (cc-superimpose (outline-flash (+ 100 (pict-width res-pic)) (+ 20 (pict-height res-pic)))
                                  res-pic)
                  res-pic))
  (hc-append (arrow ((get-current-code-font-size)) 0)
             (filled-rectangle ((get-current-code-font-size)) 6 #:color "White" #:draw-border? #f) out))


(define (pin-pointer pic dx dy width height)
  (define width^ (pict-width pic))
  (pin-over pic (- dx 5) dy (filled-rectangle (if (and width (< width width^))
                                                  (+ 10 width)
                                                  (+ 15 width^)) ;;(+ 15 (pict-width subpic))
                                        (if (and height (< height (pict-height pic)))
                                            height
                                            (+ 8 (pict-height pic)))
                                        #:color (make-object color% 0 0 0 0)
                                        #:border-color (make-object color% #xfc #xbf #x49 0.5)
                                        #:border-width 4)))

(define bt (lambda (txt [size 25])
             (text txt (list 'bold) size)))

(define (t txt) (text txt null 25))
(define okay (colorize (text "✓" null 25) "dark green"))
(define not-okay (colorize (text "X" null 25) "dark red"))
(define unknown (colorize (t "?") "dark blue"))
(define n/a (t "N/A"))


(define (make-env-table data cell-width)
  (define header (cc-superimpose (filled-rectangle cell-width 20 #:draw-border? #t
                                                 #:color (make-object color% 222 222 222)
                                                 #:border-color (make-object color% 222 222 222)
                                                 #:border-width 2)
                                 (text "Type Environment Γ" null 18)))
  (vl-append header
             (table 1
                    (map (lambda (x)
                           (cc-superimpose (filled-rectangle cell-width (pict-height x) #:color "white") x))
                         data)
                    lc-superimpose
                    lc-superimpose
                    0
                    0)))
