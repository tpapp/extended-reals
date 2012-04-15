;;;; package.lisp

(defpackage #:extended-reals
  (:use #:cl #:alexandria)
  (:nicknames #:xr)
  (:shadow #:= #:< #:> #:<= #:>=)
  (:export
   :inf
   :-inf
   :inf?
   :-inf?
   :infinite?
   :extended-real
   :=
   :<
   :>
   :<=
   :>=
   :with-template
   :lambda-template))
