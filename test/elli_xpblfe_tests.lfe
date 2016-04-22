(defmodule elli_xpblfe_tests
  (behaviour ltest-unit)
  (export (elli_xpblfe_test_ 0))) 

(include-lib "ltest/include/ltest-macros.lfe")

(deftestgen elli_xpblfe
  "Tests based on [`elli_middleware_tests`][1].

  [1]: https://github.com/knutin/elli/blob/master/test/elli_middleware_tests.erl"
  `#(setup ,(defsetup setup) ,(defteardown teardown)
           [,(_test (hello_world)) ,(_test (short_circuit))]))


;;;===================================================================
;;; Tests
;;;===================================================================

(defun short_circuit ()
  (let* ((url              "http://localhost:3002/middleware/short-circuit")
         (`#(ok ,response) (httpc:request url)))
    (is-equal 200              (status response))
    (is-equal "LFE"            (x_powered_by response))
    (is-equal "short circuit!" (body response))))

(defun hello_world ()
  (let* ((url              "http://localhost:3002/hello/world")
         (`#(ok ,response) (httpc:request url)))
    (is-equal 200            (status response))
    (is-equal "LFE"          (x_powered_by response))
    (is-equal "Hello World!" (body response))))


;;;===================================================================
;;; Helper functions
;;;===================================================================

(defun status ([`#(#(,_ ,status ,_) ,_ ,_)] status))

(defun headers ([`#(,_ ,headers ,_)] (lists:sort headers)))

(defun body ([`#(,_ ,_ ,body)] body))

(defun x_powered_by (response)
  (proplists:get_value "x-powered-by" (headers response)))

(defun setup ()
  (application:start 'crypto)
  (application:start 'public_key)
  (application:start 'ssl)
  (inets:start)
  (let* ((config    `[#(mods [#(elli_example_middleware [])
                              #(elli_middlware_compress [])
                              #(elli_example_callback [])
                              #(elli_xpblfe [])])])
         (`#(ok ,p) (elli:start_link `[#(callback elli_middleware)
                                       #(callback_args ,config)
                                       #(port 3002)])))
    (unlink p)
    `[,p]))

(defun teardown (pids) (lists:map #'elli:stop/1 pids))
