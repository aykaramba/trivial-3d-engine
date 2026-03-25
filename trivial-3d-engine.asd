(asdf:defsystem #:trivial-3d-engine
  :description "A trivial 3d engine."
  :author "some@one.com"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :entry-point "trivial-3d-engine:start-app"
  :depends-on (#:sketch) ; add clog plugins here as #:plugin for run time
  :components ((:file "trivial-3d-engine")))
