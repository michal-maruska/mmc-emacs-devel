

;; /usr/lib/xemacs/xemacs-packages/lisp/scheme/cmuscheme48.el
(require 'mmc-simple)
(require 'mmc-lisp)
(require 'mmc-string)
;(require 'scheme)
(require 'xcscope)



;; (setq scheme-mode-hook (pop scheme-mode-hook)
;; (remove-hook
(add-hook 'scheme-mode-hook
  (lambda ()
    (if (featurep 'xcscope)
	(cscope-minor-mode)
      ;; I use it for gauche  genstub files .... or gtk+ ?
      )))

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
(require 'scheme-indentation)

(require 'scheme-font-lock)


;;; running:   note, that many keys are bound only _after_ we run scheme..
(setq scheme-program-name
      ;; not used/needed  i detect it dynamically  `scheme-determine-program'
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
     ;;(kbd "C-m i")
     (define-key inferior-scheme-mode-map [(control ?i)] 'scheme-complete)
     (define-key inferior-scheme-mode-map [(control meta ?x)] nil)
     (define-key inferior-scheme-mode-map [(meta control ?x)] my-lisp-map)
     (define-key inferior-scheme-mode-map [(control ?c) (control ?k) ]
       'comint-kill-subjob)
     (define-key inferior-scheme-mode-map [(control ?x) (control ?r)]
       'scheme-reload)
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
     ((or (string-match "/gambit/" file-name))
      "/usr/local/gambit-v4.8.5/bin/gsi")

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

(defun scheme-module-name ()
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
  (let ((module-name (scheme-module-name))
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
	 ;;(module-name (scheme-module-name))
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
  (comint-send-string  (current-buffer)
		       ",config ,load /home/mmc/activity/scheme/packages.scm\n")
  (comint-send-string  (current-buffer) (format ",reload-package %s\n" package))
  (comint-send-string  (current-buffer) (format ",user\n"))
  (comint-send-string  (current-buffer) (format ",in %s\n" package)))



;;;
(defun scheme-reload-package (buffer)
  "signal, that the (current) BUFFER has changed, and its defintion
must be reloaded."
  (interactive (list (current-buffer)))
  (let ((module-name (scheme-module-name)))
    (scheme-send-string (format ",reload-package %s\n" module-name))))

(defun scheme-step-in (buffer)
  "signal, that the (current) BUFFER has changed, and its defintion
must be reloaded."
  (interactive (list (current-buffer)))
  (let ((module-name (scheme-module-name)))
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

(eval-after-load
    "scheme"
  '(progn
     (autoload 'sh-set-shell "sh-script")
     (define-key scheme-mode-map [(control ?h) ?W] 'gauche-where-is)
     (define-key scheme-mode-map [(control ?c) ?:] 'sh-set-shell)
     ))
;;(define-key scheme-mode-map [(control ?h) ?W] 'gauche-where-is)


(require 'assoc)

(require 'mmc-gauche)

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
