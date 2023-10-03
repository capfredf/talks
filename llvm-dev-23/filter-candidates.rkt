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
          (t "When a PreferredType is not Null,")
          (code-block "for (auto Candidate : CompletionCandiates)"
                      "    if (isCompatible(Candidate.getType(), PreferredType))"
                      "        saveAsCompletionString(Candidate)")
          (code-block "isCompatible(clang::Type CandidateType, clang::Type PreferredType) ")
          (t "Examples:")
          (code-block "isCompatible(<int>, <int>) = true")
          (code-block "isCompatible(<int>, <int&>) = true")
          (code-block "isCompatible(<int>, <std::string>) = false")
          (code-block "isCompatible(<CXXRecord:Car &>, <CXXRecord:Vehicle &>) = true")
          (code-block "isCompatible(<CXXRecord:Car &>, <CXXRecord:Sedan &>) = false")))

(module+ main
  (filter-candidates))
