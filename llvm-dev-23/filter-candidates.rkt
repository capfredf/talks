#lang slideshow
(require ppict/2
         racket/splicing
         pict/code
         (prefix-in mp: metapict)
         "../assets/asset.rkt"
         "utils.rkt")
(provide (all-defined-out))

(define (filter-candidates)
  (pslide #:title "Filter Candidates"
          #:layout 'center
          (code-block "When a PreferredType is not Null,")
          (code-block "for (auto Candidate : CompletionCandiates)"
                      "    if (isCompatible(Candidate.getType(), PreferredType))"
                      "        saveAsCompletionString(Candidate)")
          (code-block "isCompatible(Type CandidateType, Type PreferredType) ")
          (code-block "isCompatible(Integer, Integer) = true")
          (code-block "isCompatible(Integer, Integer&) = true")
          (code-block "isCompatible(Integer, String) = false")
          (code-block "isCompatible(Car &, Vehicle&) = true")
          (code-block "isCompatible(Car &, Sedan &) = false")))

(module+ main
  (filter-candidates))
