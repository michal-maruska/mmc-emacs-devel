
;;; `indentation':(scsh)
(when t ;'define-indentation
  (put 'with-current-input-port 'scheme-indent-function 2)
  (put 'call-with-input-string  'scheme-indent-function 'defun)
  (put 'with-db 'scheme-indent-function 1)
  (put 'pg:with-private-handle* 'scheme-indent-function 2)
  (put 'pg:with-cursor 'scheme-indent-function 3)
  (put 'awk 'scheme-indent-function 3)
  (put 'syntax-case 'scheme-indent-function 2)

  (put 'gtk-input-add 'scheme-indent-function 2)

  (put 'do-in-subdirs 'scheme-indent-function 'defun)
  (put 'when 'scheme-indent-function 'defun)
  (put 'unless 'scheme-indent-function 1)
  (put 'with-cwd 'scheme-indent-function 1)
  (put 'with-cwd* 'scheme-indent-function 1)


  (put 'if 'scheme-indent-function 2)

  (put 'conditional 'scheme-indent-function 'defun)

  (put 'do-in-subdirs 'scheme-indent-function 'defun)
  (put 'with-handler 'scheme-indent-function 1)	; 'defun)

  (put 'with-interrupt-handler 'scheme-indent-function 2)
  (put 'close-after 'scheme-indent-function 2)

  (put 'run/listen 'scheme-indent-function 1)

  (put 'call-with-client-socket 'scheme-indent-function 1)
  ;gauche:
  (put 'with-error-handler 'scheme-indent-function 1)	; 'defun)
  (put 'with-error-handler* 'scheme-indent-hook 1)
  (put 'with-exception-handler 'scheme-indent-function 1)
  (put 'with-exit-exception-handler 'scheme-indent-function 1)
  (put 'with-exit-exception-handler* 'scheme-indent-function 2)
  (put 'with-chained-exception-handler* 'scheme-indent-function 1)

  (put 'my-with-exception-handler 'scheme-indent-function 2)

  (put 'for-debug 'scheme-indent-function 'defun)

  (put 'xkb-for-each-keycodes 'scheme-indent-function 'defun)
  (put 'filter-keycodes 'scheme-indent-function 'defun)
  (put 'test-expected 'scheme-indent-function 'defun)

  (put 'with-port-locking 'scheme-indent-function 'defun)

  (put 'iff 'scheme-indent-function 'defun)

  ;; pg:
  (put 'copy-import 'scheme-indent-function 2)
  (put 'do-w/-nfs-dir 'scheme-indent-function 2)
  (put 'map-dir-files 'scheme-indent-function 1)
  (put 'in-trasaction* 'scheme-indent-function 2)


  (put 'with-handler* 'scheme-indent-function 1)
  (put 'with-mutex 'scheme-indent-function 1)
  (put 'with-mutex* 'scheme-indent-function 1)
  (put 'with-locking-mutex 'scheme-indent-function 1)
  (put 'with-locking-mutex* 'scheme-indent-function 1)
  (put 'pg:with-handle-of* 'scheme-indent-function 2)
  (put 'pg:with-handle-of 'scheme-indent-function 'defun)
  (put 'pg:with-admin-handle 'scheme-indent-function 1)

  (put 'with-kill-handler 'scheme-indent-function 'defun)

  (put 'let-optionals* 'scheme-indent-function 2)
  (put 'let-optionals 'scheme-indent-function 2)
  (put 'let-args 'scheme-indent-function 2)
  (put 'let1 'scheme-indent-function 2) ;let
  (put 'make-record-type 'scheme-indent-function '1) ;let

  (put 'and-let* 'scheme-indent-function 'defun)
  (put 'let-thread-fluid 'scheme-indent-function 2)

  (put 'n-times  'scheme-indent-function 1)
  (put 'with-fluid-bound 'scheme-indent-function 2)
  (put 'with-pg-result* 'scheme-indent-function 1)
  (put 'with-pg-handle* 'scheme-indent-function 1)

  (put 'call-with-current-continuation 'scheme-indent-function 'defun)
  (put 'set-file-times 'scheme-indent-function 1)


  (put 'walk-bfs  'scheme-indent-function 1)
  (put 'walk-dfs-files  'scheme-indent-function 1)
  (put 'walk-dfs-fs  'scheme-indent-function 1)
  (put 'walk-dfs 'scheme-indent-function 3)
  (put 'walk-down 'scheme-indent-function 2)



  (put 'spawn-registered-to*  'scheme-indent-function 1)
  (put 'spawn* 'scheme-indent-function 1)
  (put 'spawn 'scheme-indent-function 1)



  (put 'write-to-file 'scheme-indent-function 1)
  (put 'let-match 'scheme-indent-function 1)
  (put 'let-values 'scheme-indent-function 1)
  (put 'hash-table-for-each 'scheme-indent-function 1)

  (put 'catch* 'scheme-indent-function 1)
  (put 'catch 'scheme-indent-function 1)

  (put 'make-fs-object  'scheme-indent-function 2)
  (put 'fold-right  'scheme-indent-function 1)
  (put 'map 'scheme-indent-function 1)
  (put 'map-numbers 'scheme-indent-function 2)
  (put 'map-numbers* 'scheme-indent-function 3)

  (put 'for-numbers 'scheme-indent-function 2) ; fixme! needs a customization!
  (put 'for-numbers* 'scheme-indent-function 3)
  (put 'for-numbers< 'scheme-indent-function 2) ; fixme! needs a customization!
  (put 'for-numbers<* 'scheme-indent-function 3)



  (put 'find-in-numbers* 'scheme-indent-function 3)

  (put 'every 'scheme-indent-function 1)

  (put 'map-pairwise 'scheme-indent-function 1)

  (put 'for-each 'scheme-indent-function 1)
  (put 'for-each-reverse 'scheme-indent-function 1)
  (put 'for-each-reverse* 'scheme-indent-function 1)
  (put 'map-reverse 'scheme-indent-function 1)
  ;; sequences
  (put 'for-each-with-index 'scheme-indent-function 2)

  (put 'g-signal-connect 'scheme-indent-function 2)
  (put 'set-handler 'scheme-indent-function 2)

  (put 'table-walk 'scheme-indent-function 2)

  (put 'logformat-color 'scheme-indent-function 2)
  (put 'logformat-colors 'scheme-indent-function 2)

  (put 'cdisplay 'scheme-indent-function 2)
  (put 'ccformat 'scheme-indent-function 3)


  (put 'run-program-process-output-report-error 'scheme-indent-function 2)
  (put 'remote-run  'scheme-indent-function 1)


  (put 'switch-by-value 'scheme-indent-function 1)
  (put 'string-join-non-\#f 'scheme-indent-function 1)
  (put 'get-tuples-alist 'scheme-indent-function 1)

  (put 'regexp-for-each 'scheme-indent-function 2)
  (put 'in-section 'scheme-indent-function 1)
  (put 'sub-section 'scheme-indent-function 1)


  (put 'with-env 'scheme-indent-function 2)
  (put 'receive  'scheme-indent-function 2)
  (put 'with-remind 'scheme-indent-function 2)

  (put 'with-input-output-file 'scheme-indent-function 2)
  (put 'with-output-to-file* 'scheme-indent-function 1)
  (put 'with-input-from-file* 'scheme-indent-function 1)
  (put 'with-current-input-port* 'scheme-indent-function 1)

  (put 'copy-data->db 'scheme-indent-function 1)
  (put 'put-in-table 'scheme-indent-function 1)
  (put 'walk-table 'scheme-indent-function 2)
  (put 'coroutine 'scheme-indent-function 'defun)


  (put 'safe-quiet 'scheme-indent-function 2)
  (put 'with-current-output-port* 'scheme-indent-function 2)
  (put 'with-current-output-port 'scheme-indent-function 1)

  (put 'with-current-input-port-here 'scheme-indent-function 2)
  (put 'with-current-output-port-here 'scheme-indent-function 2)

  (put 'if-bound 'scheme-indent-function 2)
  (put 'if-bound-and 'scheme-indent-function 3)
  (put 'if-match 'scheme-indent-function 2)
  (put 'rxmatch-if 'scheme-indent-function 2)
  (put 'rxmatch-let 'scheme-indent-function 2)



  (put 'pg-foreach-result 'scheme-indent-function 2)
  (put 'fd:foreach 'scheme-indent-function 2)

  (put 'pg:with-private-handle* 'scheme-indent-function 2)
  (put 'pg:with-private-handle 'scheme-indent-function 1)


  (put 'foreach-db-foto 'scheme-indent-function 2)
  (put 'for-person-foto-files 'scheme-indent-function 2)

  (put 'pg:for-namespace 'scheme-indent-function 2)
  (put 'pg-map-result  'scheme-indent-function 2)
  (put 'with-foto-file-image 'scheme-indent-function 1)
  (put 'with-ref+ 'scheme-indent-function 1)
  (put 'unwind-protect 'scheme-indent-function 1)
  (put 'unwind-protect* 'scheme-indent-function 1)
  (put 'simple-catch 'scheme-indent-function 1)

  (put 'with-triggers-disabled 'scheme-indent-function 2)
  (put 'with-transaction 'scheme-indent-function 1)
  (put 'with-transaction* 'scheme-indent-function 1)

  (put 'null-unless 'scheme-indent-function 1)
  (put 'report-time  'scheme-indent-function 2)
  (put 'temp-file-iterate 'scheme-indent-function 2)
  (put 'args-fold  'scheme-indent-function 1)
  (put 'string-join 'scheme-indent-function 3)
  (put 'string-compare 'scheme-indent-function 2)

  (put 'bdb:with-write-cursor 'scheme-indent-function 2)


  (put 'pg-map-table 'scheme-indent-function 2)
  (put 'pg:map-tuples 'scheme-indent-function 2)
  (put 'pg:map-tuples-result 'scheme-indent-function 2)

  (put 'db-map-cursor 'scheme-indent-function 2)

  (put 'map-dir-subdirs* 'scheme-indent-function 2)
  (put 'map-dir-files* 'scheme-indent-function 2)

  (put 'pg:print-tuple 'scheme-indent-function 2)

  (put 'with-exit-handler  'scheme-indent-function 2)

  (put 'with-db-transaction*  'scheme-indent-function 1)

  (put 'for-person-foto-files 'scheme-indent-function 2)

  (put 'modify-attnames  'scheme-indent-function 3)

  (put 'with-interrupt-disabled 'scheme-indent-function 1)

  (put 'let-fluid 'scheme-indent-function 2)
  (put 'with-triggers-disabled* 'scheme-indent-function 2)
  (put 'let-keywords* 'scheme-indent-function 2)
  ;; mop
  (put 'letrec 'scheme-indent-hook 1)
  (put 'make-method  'scheme-indent-hook 1)
  (put 'add-method   'scheme-indent-hook 'defun)
  (put 'pg-exec   'scheme-indent-hook 1)
  (put 'with-pg-handle* 'scheme-indent-hook 2)

  (put 'with-exception-handler* 'scheme-indent-hook 2)
  (put 'my-with-exception-handler* 'scheme-indent-hook 2)

  (put 'with-chained-exception-exit-handler-safe* 'scheme-indent-hook 1)

  (put 'walk-foto-tree  'scheme-indent-hook 2)
  (put 'binary-search-file 'scheme-indent-hook 2)
  (put 'binary-search-file-new 'scheme-indent-hook 2)
  (put 'update-slot!  'scheme-indent-hook 2)
  (put 'modify-with-function-filters  'scheme-indent-hook 1)
  (put 'dotimes 'scheme-indent-hook 1)
  (put 'parse-options 'scheme-indent-hook 1)


  (put 'hash-filter 'scheme-indent-hook 1)
  ;; let-widgts
  (put 'window 'scheme-indent-hook 1)

  (put 'receive-unpack 'scheme-indent-hook 3)
  (put 'option  'scheme-indent-hook 3)


  (put 'map-person 'scheme-indent-hook 1)
  (put 'filter-map 'scheme-indent-hook 1)
  (put 'filter 'scheme-indent-hook 1)

  ;;;
  (put 'html:table 'scheme-indent-hook 2)
  (put 'html:tr 'scheme-indent-hook 2)
  (put 'parametrize 'scheme-indent-hook 1)

  (put 'format  'scheme-indent-hook 1)
  (put 'logformat  'scheme-indent-hook 1)
  (put 'parameterize 'scheme-indent-hook 1)

  ;; pg:
  (put 'slot-set!  'scheme-indent-hook 2)
  ;;xlib

  (put 'x-atom->name 'scheme-indent-hook 1)
  ;; gtk:
  (put 'spawn-drawing-window 'scheme-indent-hook 2)
  (put 'gdk-draw-layout-center 'scheme-indent-hook 2)

  (put 'guard 'scheme-indent-hook 1)
  (put 'rxmatch-case 'scheme-indent-hook 1)
  (put 'pg-set-local-notice-processor 'scheme-indent-hook 1)


  ;;
  (put 'set-signal-handler! 'scheme-indent-hook 1)
  (put 'build-lazy-search-tree 'scheme-indent-hook 2)


  ;;
  (put 'cc-sequence 'scheme-indent-hook 1)
  (put 'rs-for-each 'scheme-indent-hook 1)
  (put 'rs-map 'scheme-indent-hook 1)
  (put 'pg:lookup-attribute 'scheme-indent-hook 1)
  (put 'hypergraph-connect 'scheme-indent-hook 1)
  (put 'hash-table-map 'scheme-indent-hook 1)
  (put 'bind-key 'scheme-indent-hook 3)
  (put 'pg:add-database-hook 'scheme-indent-hook 2)
  (put 'bind-key  'scheme-indent-hook 3)

  ;; kahua:
  (put 'run-cont 'scheme-indent-hook 2)
  (put 'entry-lambda 'scheme-indent-hook 1)
  (put 'aif  'scheme-indent-hook 3)
  (put 'kahua-add-hook! 'scheme-indent-hook 1)


  ;;
  (put 'with-translator 'scheme-indent-hook 1)
  (put 'tr: 'scheme-indent-hook 1)
  (put 'td: 'scheme-indent-hook 1)
  (put 'table: 'scheme-indent-hook 1)
  (put 'font: 'scheme-indent-hook 1)
  (put 'form: 'scheme-indent-hook 1)
  (put 'select: 'scheme-indent-hook 1)
  (put 'frameset: 'scheme-indent-hook 1)
  (put 'with-translation-gender 'scheme-indent-hook 1)

  (put 'body: 'scheme-indent-hook 1)
  (put 'intersperse 'scheme-indent-hook 1)
  )

(provide 'scheme-indentation)
