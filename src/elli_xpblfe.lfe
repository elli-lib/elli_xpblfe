(defmodule elli_xpblfe
  (doc "Add `X-Powered-By: LFE` header to all responses.")
  (export (postprocess 3)))

(defun postprocess
  "```http
HTTP/1.1 451 Unavailable For Legal Reasons
X-Powered-By: LFE
```"
  ([req `#(,code ,body) config]
   (when (orelse (is_integer code) (=:= 'ok code)))
   (postprocess req `#(,code [] ,body) config))
  ([_req `#(,code ,headers ,body) _config]
   (when (orelse (is_integer code) (=:= 'ok code)))
   `#(,code [#(#"X-Powered-By" #"LFE") . ,headers] ,body)))
