;; emacs @ ubuntu is broken somehow!


;; (setq scheme-font-lock-keywords scheme-font-lock-keywords-1)
;; (setq scheme-font-lock-keywords
;; scheme-font-lock-keywords-1


;; /usr/lib/xemacs/xemacs-packages/lisp/scheme/cmuscheme48.el
(require 'mmc-simple)
(require 'mmc-lisp)
(require 'mmc-string)
;(require 'scheme)

;; (setq scheme-mode-hook (pop scheme-mode-hook)
;; (remove-hook
(add-hook 'scheme-mode-hook
  (lambda ()
    (cscope-minor-mode)		  ; i use it for gauche  genstub files .... or gtk+ ?
    ))

; (mapcar 'car after-load-alist)

;(setcdr (assoc "\\(\\`\\|/\\)scheme\\(\\.elc\\|\\.el\\)?\\(\\.gz\\)?\\'" after-load-alist) nil)
;(adelete after-load-alist "\\(\\`\\|/\\)scheme\\(\\.elc\\|\\.el\\)?\\(\\.gz\\)?\\'")
;(aget after-load-alist "\\(\\`\\|/\\)scheme\\(\\.elc\\|\\.el\\)?\\(\\.gz\\)?\\'")

;;; by Riastradh:
(eval-after-load 'scheme
  '(progn
     ;; _ symbol
     ;; 2 means CHAR is the second character of such a sequence.
     ;; 3 means CHAR is the start of a two-char comment end sequence.
     ;; n means CHAR is part of a nestable comment sequence.
     ;; b means CHAR is part of comment sequence b.
     (modify-syntax-entry ?\| "_ 23bn" scheme-mode-syntax-table)
     (modify-syntax-entry ?\# "' 14bn" scheme-mode-syntax-table)


     ;; my:
     (modify-syntax-entry ?# "_ 14" scheme-mode-syntax-table) ; symbol
     (modify-syntax-entry ?! "_ 23" scheme-mode-syntax-table) ;
     ))




; (setq comment-start ";"
;       comment-end   "")

(require 'mmc-doc)



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


;;; running:   note, that many keys are bound only _after_ we run scheme..
(setq scheme-program-name               ; not used/needed  i detect it dynamically  `scheme-determine-program'
      ;;"scsh"
      ;;"scheme48"
      "guile"
      )


(defun scheme-reload ()                 ; the scsh version. i have also for gauche
  ""
  (interactive)
  (let ((command (car (process-command (get-buffer-process (current-buffer))))))
    (if (string= command "scsh")
        (call-interactively 'scsh-reload-package))
      (comint-send-string  (current-buffer) "(reload-modified-modules)\n")))


(autoload 'run-scheme  "cmuscheme" "Run an inferior Scheme process." t)
;;(require 'cmuscheme)
(eval-after-load "cmuscheme"
  '(progn

     ;(modify-syntax-entry ?-  "-" inferior-scheme-mode-syntax-table)

     ;; (keymap-parent inferior-scheme-mode-map)   comint ??
     '(set-keymap-parent inferior-scheme-mode-map
                         lisp-mode-shared-map)

     (define-key inferior-scheme-mode-map [(control ?i)] 'scheme-complete)
     (define-key inferior-scheme-mode-map [(control meta ?x)] nil)
     (define-key inferior-scheme-mode-map [(meta control ?x)] my-lisp-map)
     (define-key inferior-scheme-mode-map [(control ?c) (control ?k) ] 'comint-kill-subjob)
     (define-key inferior-scheme-mode-map [(control ?x) (control ?r)] 'scheme-reload)
     (define-key inferior-scheme-mode-map [(control ?c) ?u]
       (lambda ()
         (interactive)
         (comint-send-string (current-buffer) ",user")))


     (define-key inferior-scheme-mode-map [(alt ?.)] 'gtk-doc)

     (define-key inferior-scheme-mode-map [f5]
       (lambda () (interactive)
         (comint-send-string
          (current-buffer)
          ",config ,load /x/cvs/sourceforge/scsh/sunet/modules.scm /home/mmc/activity/scheme/packages.scm\n")))
     (modify-syntax-entry ?, "'" inferior-scheme-mode-syntax-table)	; ,configure-... i want to dabbrev-expand only the configure-
     ))




;; customize comint: i don't want them in selected window!
(mapc (lambda (item)
	(setq same-window-buffer-names
	      (delete item same-window-buffer-names)))
      '("*inferior-lisp*" "*scheme*"))
;special-display-buffer-names
; special-display-regexps



;;; Hardwired customization:
(defun scheme-determine-program ()
  "which (scheme) interpreter is for the current buffer?"
  (let ((file-name (expand-file-name  (buffer-file-name))))
    ;;
    (cond
     ((or (string-match "/gauche/" file-name)
          (string-match "/ga/" file-name))
      "gosh")

     ((string-match "activity/scheme" file-name)
     "scsh -lm /usr/local/activity/scheme/packages.scm")

     ((string-match "activity/guile" file-name)
	   "guile")

     ;('t "scsh  -lm /usr/local/activity/scheme/packages.scm -lm /x/cvs/sourceforge/scsh/sunet/modules.scm")
     (t "gosh")
     )))
;;  -lm /home/mmc/sc/.SSAX/collections/ssax-sxml/packages.scm


;; emacs ??x
(defun parent-buffer (buffer)
  "where is the definition of the structure for the buffer (should be filename)"
  (let* ((mode (major-mode-of buffer))
	 (parent
	  ;; mapping ->
	  (cond ((eq mode 'scheme-mode) "~/activity/scheme/packages.scm")
		('t			; tex  auctex ...
		 nil))))
    ;; the PARENT involves some trickery:
    (unless (bufferp parent)
      (let ((possible-buffer (get-file-buffer parent)))
	(if (bufferp possible-buffer)
	    (setq parent possible-buffer))))
    ;;
    (if parent
	(cond
	 ((bufferp parent)
	  (display-buffer parent))
	 ((and (stringp parent)
	       (or
		(file-exists-p parent)))
	  (find-file-other-window parent)
	  (setq parent (current-buffer)))))
    parent))

;(string-match "-m \\(\\(?:\\s_\\|\\w\\)*\\) "  "-m lksada:lksdfj ")

(defun scheme-modul-name ()
  ""
  ;(unwind-protect
  ;(catch 'error-var
  (save-excursion
    (goto-char (point-min))
    (forward-line 1)
    ;; exception ??
    (search-forward-regexp "-m \\(\\(?:\\s_\\|\\w\\)*\\) " (point-eol))
    (match-string-no-properties 1))
    ;(error . nil)
  )


(defun search-buffer-regexp (&rest rest)
  ""
  (goto-char (point-min))
  (apply 'search-forward-regexp rest))



(defun scheme-compose-package-definition (package)
  ""
  (let ((file (replace-regexp-in-string ":" "/" package)) ; [16 ott 02]
	(opens '(scsh scheme))
	(exports '()))
    ;(indenta
    (princ
     `(define-structure ,package (export ,@exports)
			(open ,@opens)
	(files ,file))
     (current-buffer))))

;;; Enhancement:
(defun scheme-send-string (string)
  ""
  (comint-send-string (scheme-proc) string))

;;;
(defun scheme-goto-package-definition (buffer)
  ""
  (interactive (list (current-buffer)))
  (let ((module-name (scheme-modul-name))
	(parent-buffer (parent-buffer buffer)))

    ;; i want to switch, but:
    (switch-to-buffer-other-window parent-buffer)
    (if (search-buffer-regexp (concat "define-structure *" (regexp-quote module-name)) nil 't)
	parent-buffer
      (goto-char (point-max))
      (scheme-compose-package-definition module-name))))


;; fixme!
;; ---------------------------------------------------------------------
;; (defun goto-parent-buffer (buffer)
;;   ""
;;   (interactive (list (current-buffer)))
;;   (let ((parent (parent-buffer buffer)))
;;     (set-buffer parent)
;;     parent))


(global-set-key [(control ?x) ?'] 'goto-parent-buffer)
(defun goto-parent-buffer (buffer)
  ""
  (interactive (list (current-buffer)))
  (let ((parent (parent-buffer buffer)))
    (if parent
	(cond
	 ((bufferp parent)
	  (display-buffer parent))
	 ((and (stringp parent)
	       (file-exists-p parent))
	  (find-file-other-window parent))))))

(global-set-key [(control ?x) ?'] 'goto-parent-buffer)
;; ---------------------------------------------------------------------

;; (defun scheme-display ()
;;   ""
;;   (interactive)
;;   (display-comint-buffer
;;    '(process-buffer (scheme-proc))
;;    '(run-scheme (scheme-determine-program))))


;; (let (buffer)
;;     (if (and (boundp 'scheme-proc)
;; 	     (setq buffer (process-buffer (scheme-proc))))
;; 	(display-buffer buffer 't)
;;       (run-scheme (scheme-determine-program))))

; could be via Hyperbole ??



;; (let (buffer)
;;     (if (and (boundp 'scheme-proc)
;; 	     (setq buffer (process-buffer (scheme-proc))))
;; 	(display-buffer buffer 't)
;;       (run-scheme (scheme-determine-program))))

(eval-after-load
    ;; bug: "scheme" would catch  tempo/scheme.el -> recursion!
    'scheme
  '(progn
     (define-key scheme-mode-map [(control ?x) ?'] 'scheme-goto-package-definition)
     ;; (require 'tempo)
     (load "tempo/tempo-scheme.el")

					;(define-key scheme-mode-map [(control ?c) ?d] 'scheme-display)
					;(define-key scheme-mode-map [(control ?c) ?d] nil)


     (define-key scheme-mode-map [(control ?x) ?'] 'scheme-goto-package-definition)
					;(define-key scheme-mode-map [(control ?c) ?j ?m] nil)

     (define-key scheme-mode-map [(control meta ?x)] nil)
     (define-key scheme-mode-map [(meta control ?x)] my-lisp-map)
					;(define-key scheme-mode-map [(control meta ?x)] nil)



     (define-key scheme-mode-map [(control  ?c) ?j] 'scheme-step-in)
     (define-key scheme-mode-map [(control  ?c) (control ?j)]
       (lambda ()
	 (interactive)
	 (find-file "/linux/11/x/activity/emacs/mmc-emacs-devel/mmc-scheme.el")))

     (define-key scheme-mode-map [(control  ?c) ?r] 'scheme-reload-package)


     (define-key scheme-mode-map [(control ?x) ?'] 'scheme-goto-package-definition)
					;(define-key scheme-mode-map [(control ?c) ?d] 'scheme-display)
					;(define-key scheme-mode-map [(control ?c) ?d] nil)


     (define-key scheme-mode-map [(control ?x) ?'] 'scheme-goto-package-definition)
					;(define-key scheme-mode-map [(control ?c) ?j ?m] nil)

     (define-key scheme-mode-map [(control meta ?x)] nil)
     (define-key scheme-mode-map [(meta control ?x)] my-lisp-map)
					;(define-key scheme-mode-map [(control meta ?x)] nil)


     (define-key scheme-mode-map [(control ?c) ?e] 'scheme-export-symbol)
     (modify-syntax-entry ?, "'" scheme-mode-syntax-table) ; ,configure-... i want to dabbrev-expand only the configure-
     (modify-syntax-entry ?@ "'" scheme-mode-syntax-table)



     (define-key scheme-mode-map [(meta ?e)] 'up-list)
     ))


(defun scheme-documentation-ps ()
  ""
  (interactive)
  ;; (hyper "/internet/scheme/scsh/scsh-0.6.0/doc/scsh-manual/man.ps")
  (shell-command "gv /internet/scheme/scsh/scsh-0.6.0/doc/scsh-manual/man.ps")); could be via Hyperbole ??

;;;
(defconst scheme-comma-commands
  (alist-from-list
   (list
    "batch" "level"
    "bench" "levels"
    "bound?" "load"
    "break-on-warnings" "load"
    "build" "new"
    "collect" "open"
    "condition" "pop"
    "config" "preview"
    "config-package-is" "proceed"
    "debug" "push"
    "dis" "reload"
    "dump" "reset"
    "exec" "run"
    "exit" "structure"
    "exit-when-done" "threads"
    "expand" "time"
    "flush" "trace"
    "for-syntax" "translate"
    "forget" "undefine"
    "form-preferred" "untrace"
    "go" "user"
    "help" "user-package-is"
    "in" "where"
    "inspect"))
  "comma commands which get COMPLETED inside comint-scheme")



(defconst sawfish-comma-commands
  (alist-from-list
   (list

    "access" "accessible"
    "apropos" "binding"
    "check" "collect"
    "compile" "compile-proc"
    "describe" "disassemble"
    "expand" "export"
    "help" "imports"
    "in" "interfaces"
    "load" "load-file"
    "locate" "new" "open" "profile" "quit" "reload" "step" "structures" "time" "unload" "whereis"
    ))
  "comma commands which get COMPLETED inside sawfish")



(defun member-string-in-symbols (string list)
  "consider STRING as symbol: see `member'"
  (let (symbol)
    (catch 'found
      (while list
	(setq symbol (car list)
	      list (cdr list))
	(if (string= (symbol-name symbol) string)
	    (throw 'found symbol))))))

; (member-string-in-symbols "akkf" '(z af x y))

(defun scheme-export-symbol ()
  ""
  (interactive)
  (let* ((symbol (erase-text-properties (thing-at-point 'symbol)))
	 (buffer (current-buffer))
	 ;;(module-name (scheme-modul-name))
	 (parent-buffer (scheme-goto-package-definition buffer))
	 exports)
    (setq exports (read parent-buffer))
    (when (eq (car exports) 'export)
      (if (member-string-in-symbols symbol exports)
					; throw ..
	  (message "%s already exported" symbol)
	(backward-sexp 1)
	;; if it is macro ??
	(kill-sexp 1)
	(setq exports (append (list 'export symbol)
			      (nthcdr 1 exports)))
	(princ exports parent-buffer)
	(bury-buffer parent-buffer)))

    (set-buffer buffer)))



(defun scheme-complete ()
  ""
  (interactive)
  (let ((symbol (thing-at-point 'symbol)))
    (cond ((save-excursion
	     (skip-syntax-backward "w_")
	     (equal (char-before) ?,))
	   (cib-complete (- (point) (length symbol))
			 scheme-comma-commands nil nil nil)
	   ;; if comma-command ->complete
	   ))))





;;; `fontlock:'
(defconst scheme-font-lock-keywords-5
  (eval-when-compile
    (list
     ;; package/module language
     (list (concat "(\\(define\\*?\\("
		   ;; definitions
		   "\\(\\|-interface\\|-structure"
		   ;; Macro names, as variable names.  A bit dubious, this.
                   ;;  modules.
                   ;"\\|-module\\|-structure"		;mmc
		   "\\)\\)\\>"
		   ;; Any whitespace and declared object.
		   "[ \t]*(?"
		   "\\(\\sw+\\)?")
	   '(1 font-lock-keyword-face)
	   )))
  "Subdued expressions to highlight in Scheme modes.")



;; (list (concat "(\\(def\\("
;; 	      ;; Function declarations.
;; 	      "\\(advice\\|varalias\\|alias\\|generic\\|macro\\*?\\|method\\|"
;; 	      "setf\\|subst\\*?\\|un\\*?\\|"
;; 	      "ine-\\(condition\\|\\(?:derived\\|minor\\)-mode\\|"
;; 	      "method-combination\\|setf-expander\\|skeleton\\|widget\\|"
;; 	      "function\\|\\(compiler\\|modify\\|symbol\\)-macro\\)\\)\\|"
;; 	      ;; Variable declarations.
;; 	      "\\(const\\(ant\\)?\\|custom\\|face\\|parameter\\|var\\)\\|"
;; 	      ;; Structure declarations.
;; 	      "\\(class\\|group\\|package\\|struct\\|type\\)"
;; 	      "\\)\\)\\>"
;; 	      ;; Any whitespace and defined object.
;; 	      "[ \t'\(]*"
;; 	      "\\(setf[ \t]+\\sw+)\\|\\sw+\\)?")
;;       '(1 font-lock-keyword-face)
;;       '(9 (cond ((match-beginning 3) font-lock-function-name-face)
;; 		((match-beginning 6) font-lock-variable-name-face)
;; 		(t font-lock-type-face))
;; 	  nil t))





'(font-lock-remove-keywords 'scheme-mode
  '(("anchor" (0 cvs-marked-face) ("item" nil nil (0 diary-fac)))))




'(font-lock-remove-keywords 'scheme-mode
   '(("(define-c(proc|method|generic)\\(-fix\\)?\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 2 font-lock-function-name-face)))

;; (assq 'scheme-mode font-lock-keywords-alist)

(defun ++ (&rest args)
  (font-lock-add-keywords 'scheme-mode args))

(defun ++function (function-name)
  (font-lock-add-keywords 'scheme-mode ; args)
    ;;(++
    `((,(concat "(\\b" "\\("
		function-name "\\)" "\\b")
       1 font-lock-builtin-face))))

(defun -- (&rest args)
  (font-lock-remove-keywords 'scheme-mode args))




;;; mmc: Why remove?
'(font-lock-remove-keywords 'scheme-mode
   '(
    ;("add-method" 1 font-lock-keyword-face)
    ;("(with-cwd\\s-+\\s\"\\([^\\s\"]*\\)\\s\"" 1 font-lock-variable-name-face)
    ("(with-cwd\\s-+\\s\"\\([^\\s\"]*\\)\\s\"" 1 font-lock-variable-name-face 't)

    ("(with-cwd\\s-+\\s\"\\([^\\s\"]*\\)\\s\"" 1 font-lock-variable-name-face 'prepend)	;font-lock-def-face
    ("(with-cwd\\s-+\\s\"\\([^\\s\"]*\\)\\s\"" 1 font-lock-variable-name-face 'appen)	;font-lock-def-face

    ("(with-cwd\\s-+\\s\"\\([^\\s\"]*\\)\\s\"" 1 font-lock-variable-name-face 'prepend)
    ("(with-cwd\\s-+\\([^\\s\"]*\\)" 1 font-lock-variable-name-face 'append)
    ("\\<\\(FIXME|mmc|why\?\?\\):" 1 font-lock-warning-face prepend)

;    ))
    ("if-match" . font-lock-builtin-face)
    ("rxmatch-if" . font-lock-builtin-face)

    ("let-optionals" . font-lock-builtin-face)

    ("\\<\\(FIXME\\|mmc\\):" 1 font-lock-warning-face prepend)




    ("`\\(\\(\\s_\\)+\\)'" 1 cvs-marked-face)
    ("`\\(\\(\\s_\\|\\sw\\)+\\)'" 1 cvs-marked-face prepend)
    ("`\\(\\(\\s_\\)+\\)'" 1 cvs-marked-face prepend)

    ("\\<\\(FIXME\\):" 1 font-lock-warning-face prepend)
;    ("\\<\\(FIXME\\|mmc\\):" 1 font-lock-warning-face prepend)
    ("`\\(\\(\\s_\\|\\sw\\)+\\)'" 1 font-lock-keyword-face prepend)

    ("`\\(\\s_+\\)'" 1 font-lock-keyword-face)
    ("`\\(\\s_\\+\\)'" 1 font-lock-keyword-face)
    ("`\\(\\(\\s_\\|\\sw\\)+\\)'" 1 font-lock-keyword-face)
    ("`\\(\\(\\s_\\)+\\)'" 1 font-lock-keyword-face)
    ))


(when t                                 ;'define-font-lock
  ;;("(with-cwd\\s-+\\s\"\\([^\\s\"]*\\)\\s\"" 1 font-lock-variable-name-face 'prepend)	;font-lock-def-face
  ;;("(with-cwd\\s-+\\s\"\\([^\\s\"]*\\)\\s\"" 1 font-lock-variable-name-face 'prepend)	;font-lock-def-face
  ;;("(with-cwd\\s-+\\([^\\s\"]*\\)" 1 font-lock-variable-name-face 'append)	;font-lock-def-face

  (++ '("^(import-lambda-definition\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 1 font-lock-def-face))
  (++ '("^(external-lambda-definition\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 1 font-lock-def-face))


  (++ '("^(define-foreign\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 1 font-lock-def-face))



  ;; the `modules' language:
  (++ '("(define-structure\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 1 font-lock-def-face))
  (++ '("(define-interface\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 1 gnus-face-5))



  ;; named let:
  (++ '("(\\(let\\)\\s-+\\(\\(\\sw\\|\\s_\\)+\\)"
        (1 font-lock-keyword-face prepend)
        (2 font-lock-def-face)
        ))

                                        ;(-- '("(coroutine\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 1 font-lock-def-face))

  (++ '("(\\(coroutine\\)\\s-+" 1 font-lock-def-face))
                                        ;(-- '("(coroutine\\s-+" . font-lock-def-face))



  (++ '("(\\(define-record\\|make-record-type\\)\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 2 font-lock-def-face))
  (++ '("(\\(export\\)\\s-" 1 font-lock-keyword-face))
  (++ '("(\\(open\\)\\s-" 1 font-lock-keyword-face))
  (++ '("(\\(files\\)\\s-" 1 font-lock-keyword-face))

  (++ '("(with-cwd\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 1 font-lock-variable-name-face))
					;font-lock-variable-name-face
  (++ '("(with-cwd\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 1 font-lock-variable-name-face 'append)) ;font-lock-def-face


  (++ '("\\b\\(let1\\|receive\\)\\b"  1 font-lock-keyword-face))


  (++ '("\\b\\(export\\)\\b"  1 font-lock-def-face))
  (++ '("(\\(use\\|extend\\)\\b"  1  font-lock-builtin-face))


  (++ '("\\<\\(fixme\\|mmc\\|why\\?\\?\\):" 1 font-lock-warning-face prepend)) ; even in comments
  (++ '("\\(fixme\\|mmc\\|why\\):" 1 font-lock-warning-face 'prepend)) ; even in comments

  (++function "unless")
  (++function "when")

  (++ '("add-method" . font-lock-keyword-face)) ; no prepend !!
  (++function "if-match")
  (++ '("rxmatch-\\(if\\|let\\)" . font-lock-builtin-face))

  (++ '("`\\(\\(\\s_\\|\\sw\\)+\\)'" 1 font-lock-important prepend)) ;cvs-marked-face font-lock-keyword-face


  (++function "for-each-reverse")
  (++function "map-reverse")

  (++function "let-match")
  (++function "let-optionals")

  (++function "define-type")
  ;; fixme!
                                        ;(++ '("(define-cproc\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 1 font-lock-function-name-face))

  ;; mmc: class\\|
  (++ '("(define-c\\(?:proc\\|method\\|generic\\)\\(?:-fix\\)?\\s-+\\(\\(?:\\sw\\|\\s_\\)*\\)"
                                        ;"(define-c\\(class\\|proc\\|method\\|generic\\)\\(-fix\\)?\\s-+\\(\\(\\sw\\|\\s_\\)*\\)"
        1 font-lock-function-name-face))

  ;; fixme:  make the 2nd submatch colored too!
  (++ '("(define-entry (\\(\\(\\s_\\|\\sw\\)*\\)[ )]" 1 scheme-type/class/method-face))
  (++ '("(\\(define-entry\\) " 1 font-lock-def-face))

  (++ '("(define-element \\(\\(\\s_\\|\\sw\\)*\\)" 1 scheme-type/class/method-face))

  (++ '("(\\(define-element\\)" 1 font-lock-def-face))



  ;; scheme-type/class/method-face
  (++ '("define-form-parser\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 1 scheme-type/class/method-face))

  (++ '("(select-module\\s-+\\(\\(\\sw\\|\\s_\\)+\\)" 1 scheme-type/class/method-face))


  (--
   '(++ '("(define-c\\(?:class\\|proc\\|method\\|generic\\)\\(?:-fix\\)?\\s-+\\(\\(?:\\sw\\|\\s_\\)*\\)"
                                        ;"(define-c\\(class\\|proc\\|method\\|generic\\)\\(-fix\\)?\\s-+\\(\\(\\sw\\|\\s_\\)*\\)"
          1 scheme-type/class/method-face)))


  (++ '("(define-\\(?:method\\|generic\\)\\(?:-fix\\)?\\s-+\\(\\(?:\\sw\\|\\s_\\)*\\)"
                                        ;"(define-c\\(class\\|proc\\|method\\|generic\\)\\(-fix\\)?\\s-+\\(\\(\\sw\\|\\s_\\)*\\)"
        1 scheme-type/class/method-face))

  (++ '("(define-\\(?:method\\)\\s-+\\(\\(?:\\sw\\|\\s_\\)*\\)"
                                        ;"(define-c\\(class\\|proc\\|method\\|generic\\)\\(-fix\\)?\\s-+\\(\\(\\sw\\|\\s_\\)*\\)"
        ;; fixme: scheme-type/class/method-face
        1 'font-lock-important))        ;message-header-to-face

  )

(when nil
  (string-match "(define-c\\(?:class\\|proc\\|method\\|generic\\)\\(?:-fix\\)?\\s-+\\(\\(?:\\sw\\|\\s_\\)*\\)"
                ;;"(define-cproc\\s-+\\(\\(\\sw\\|\\s_\\)*\\)"
                " (define-cproc exif-ifd-get-name (id::<int>)"
                )
  (match-string 1 " (define-cproc exif-ifd-get-name (id::<int>)")
  (match-beginning 0)
  (match-end 0)
  )
(defvar scheme-type/class/method-face (make-face 'scheme-type/class/method-face))
(set-face-foreground scheme-type/class/method-face "Black")
(set-face-background scheme-type/class/method-face "VioletRed")
;(face-background ediff-current-diff-face-Ancestor) "")


(--
 '("(define-c\\(proc\\|method\\|generic\\)\\(-fix\\)?\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 2 font-lock-function-name-face))

'(when nil
  (length (nth 1 (aget font-lock-keywords-alist 'scheme-mode)))
					;(setcdr (aget font-lock-keywords-alist 'scheme-mode) nil)
  (aput 'font-lock-keywords-alist 'scheme-mode
	(nth 2 (aget font-lock-keywords-alist 'scheme-mode))
	)
  )

(defun my-scheme-mode-hook ()
  "")
(add-hook 'scheme-mode-hook 'my-scheme-mode-hook)




;;; comint-scheme   functions:
(defun scsh-current-package ()
  "determine from the prompt!"
  (interactive)
  (save-excursion
    (let ((inhibit-field-text-motion 't))
      (beginning-of-line)
      ;(comint-skip-prompt
       ;; [[:digit:]]
      (if (looking-at "[0-9]* *\\(\\(\\s_\\|\\sw\\)*\\)>") ;6 system:scanner:sane>
	  (match-string-no-properties 1)
	nil))))


(defun scsh-reload-package (package)
  "run inside the  comint-scheme buffer, "
  (interactive (list (scsh-current-package)))
  (comint-send-string  (current-buffer) ",config ,load /home/mmc/activity/scheme/packages.scm\n")
  (comint-send-string  (current-buffer) (format ",reload-package %s\n" package))
  (comint-send-string  (current-buffer) (format ",user\n"))
  (comint-send-string  (current-buffer) (format ",in %s\n" package)))



;;;
(defun scheme-reload-package (buffer)
  "signal, that the (current) BUFFER has changed, and its defintion must be reloaded."
  (interactive (list (current-buffer)))
  (let ((module-name (scheme-modul-name)))
    (scheme-send-string (format ",reload-package %s\n" module-name))))

(defun scheme-step-in (buffer)
  "signal, that the (current) BUFFER has changed, and its defintion must be reloaded."
  (interactive (list (current-buffer)))
  (let ((module-name (scheme-modul-name)))
    (call-interactively 'switch-to-inferior-process)
    (scheme-send-string (format ",in %s\n" module-name))
    (switch-to-buffer (process-buffer (scheme-proc))))) ;-other-window



;; use `invert-word-separator' !!!
'(defun c-to-scheme (start end)
  ""
  (interactive "r")
  ;(replace-regexp "_" "-"
  (query-replace "_" "-" nil start end))

(require 'mmc-c-mode)
(eval-after-load
    "scheme"
  '(progn
     (define-key scheme-mode-map [(alt ?.)] 'gtk-doc)))




;(set-keymap-parent inferior-scheme-mode-map inferior-lisp-mode-map)

;inferior-scheme-mode-hook

;; todo:  speacila font-lock  ... skip !!
;; Stack Trace:
;; _______________________________________





(defun gauche-where-is (symbol)
  (interactive
   (list (thing-at-point 'symbol)))
  (scheme-send-string (format "(apropos '%s)\n" symbol)))

(eval-after-load
    "scheme"
  '(progn
     (autoload 'sh-set-shell "sh-script")
     (define-key scheme-mode-map [(control ?h) ?W] 'gauche-where-is)
     (define-key scheme-mode-map [(control ?c) ?:] 'sh-set-shell)
     ))
;;(define-key scheme-mode-map [(control ?h) ?W] 'gauche-where-is)

(defun gauche-find-definition (symbol)
  ""
  (interactive
   (list (thing-at-point 'symbol)))
  ;; file/line-no
  )

(defun ffap-gauche-mode (name)
  "Given string/name of sawfish/rep module: XXX.YYY.ZZZ.module,
find and return its path in the filesystem"
  (let ((relative (add-suffix-optionally
		   (translate-module-to-filename name ".") ".scm"))
        ;; /usr/bin/gosh   -e '(begin (format #t  "~a\n\n" *load-path*) (sys-exit 0))'
        (gauche-load-path '(
			    ;; todo: eval  gauche -e '*load-path*'
			    "/usr/share/gauche/0.8.13/lib"
                            "."
                            "/x/activity/scheme/gauche/bdb"
                            ;"/x/activity/scheme/gauche/pg"
                            ; /x/activity/scheme/gauche
                            "~/gauche/"
                            "/usr/share/gauche/site/lib"
                            "/usr/lib/kahua"
                            ))
        path found)
    (setq found
          (list-search-positive
           (lambda (item)
             (file-if-exists
              (file-name-in-directory item relative)))
           gauche-load-path))
    found))

(require 'assoc)

(eval-after-load "ffap"
  '(aput 'ffap-alist 'scheme-mode 'ffap-gauche-mode)
  )
;(aput 'ffap-alist ' inferior-lisp-mode 'ffap-sawfish-mode)
                                        ;ffap-alist

; interpreter-mode-alist
(add-to-list
 'interpreter-mode-alist
 '("gosh" . scheme-mode))


;; mmc: sorry Ria!
(eval-after-load "paredit"
  '(progn
     (define-key paredit-mode-map ";" 'self-insert-command)
     (define-key paredit-mode-map ")" 'self-insert-command)))

(provide 'mmc-scheme)
