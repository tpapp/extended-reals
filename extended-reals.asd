;;;; extended-reals.asd

(asdf:defsystem #:extended-reals
  :serial t
  :description "Extended real numbers for Common Lisp."
  :author "Tamas K Papp <tkpapp@gmail.com>"
  :license "Boost Software License - Version 1.0"
  :depends-on (#:alexandria)
  :components ((:file "package")
               (:file "extended-reals")))

(asdf:defsystem #:extended-reals-tests
  :serial t
  :description "Tests for the EXTENDED-REAL library."
  :author "Tamas K Papp <tkpapp@gmail.com>"
  :license "Boost Software License - Version 1.0"
  :depends-on (#:lift)
  :components ((:file "tests")))
