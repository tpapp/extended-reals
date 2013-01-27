(in-package #:cl-user)

(defpackage #:extended-reals-tests
  (:use #:cl #:lift)
  (:export #:run)
  (:import-from #:xr #:inf #:-inf))

(in-package #:extended-reals-tests)

(deftestsuite extended-reals-tests ()
  ())

;;; helper macros for defining tests

(defmacro ensure-relation (relation &body sequences)
  `(progn
     ,@(loop
         for s in sequences
         collect `(ensure (,relation ,@s)))))

(defmacro ensure-not-relation (relation &body sequences)
  `(progn
     ,@(loop
         for s in sequences
         collect `(ensure (not (,relation ,@s))))))

(defmacro ensure-paired-relation ((relation1 relation2) &body sequences)
  `(progn
     (ensure-relation ,relation1 ,@sequences)
     (ensure-relation ,relation2 ,@(mapcar #'reverse sequences))))

(defmacro ensure-not-paired-relation ((relation1 relation2) &body sequences)
  `(progn
     (ensure-not-relation ,relation1 ,@sequences)
     (ensure-not-relation ,relation2 ,@(mapcar #'reverse sequences))))

(defmacro ensure-relation-corner-cases (&rest relations)
  `(progn
     ,@(loop for r in relations
             collect `(progn
                        (ensure (,r 1))
                        (ensure (,r (inf)))
                        (ensure (,r (-inf)))
                        (ensure-error (,r))))))

(addtest (extended-reals-tests)
  relation-cornet-cases-test
  (ensure-relation-corner-cases xreal:= xreal:< xreal:> xreal:>= xreal:<=))

(addtest (extended-reals-tests)
  strict-inequalities-test
  (ensure-paired-relation (xreal:< xreal:>)
    ;; < pairs
    (1 2)
    (1 (inf))
    ((-inf) (inf))
    ((-inf) 1)
    ;; < sequences
    (1 2 3)
    (1 2 (inf))
    ((-inf) 1 4 (inf)))
  (ensure-not-paired-relation (xreal:< xreal:>)
    ;; not < pairs
    (1 1)
    (2 1)
    ((inf) (inf))
    ((inf) 1)
    ((-inf) (-inf))
    ((inf) (-inf))
    (1 (-inf))
    ;; not < sequences
    (1 2 2)
    (1 3 2)
    (1 (inf) 2)
    (1 (inf) (inf))))

(addtest (extended-reals-tests)
  inequalities-test
  (ensure-paired-relation (xreal:<= xreal:>=)
    ;; <= pairs
    (1 1)
    (1 2)
    (1 (inf))
    ((inf) (inf))
    ((-inf) (inf))
    ((-inf) (-inf))
    ((-inf) 1)
    ;; < sequences
    (1 2 2)
    (1 2 3)
    (1 2 (inf))
    (1 (inf) (inf))
    ((-inf) 1 4 (inf)))
  (ensure-not-paired-relation (xreal:<= xreal:>=)
    ;; not < pairs
    (2 1)
    ((inf) 1)
    ((inf) (-inf))
    (1 (-inf))
    ;; not <=/>= sequences
    (1 3 2)
    (1 (inf) 2)))

(addtest (extended-reals-tests)
  equality-test
  (ensure-relation xreal:=
    ;; = pairs
    (1 1)
    ((inf) (inf))
    ((-inf) (-inf))
    ;; = sequences
    (2 2 2)
    ((inf) (inf) (inf))
    ((-inf) (-inf) (-inf)))
  (ensure-not-relation xreal:=
    ;; not = pairs
    (1 2)
    (2 1)
    (1 (inf))
    ((inf) 1)
    (1 (-inf))
    ((-inf) 1)
    ;; not = sequences
    (1 2 2)
    (2 2 1)
    ((inf) (inf) 9)
    ((inf) (-inf))))
