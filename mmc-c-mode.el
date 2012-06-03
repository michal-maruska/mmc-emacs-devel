;; cc-mode.el

;; gnome

(require 'mmc-font-lock)
(require 'cc-mode)
(require 'mmc-simple)

;; rxvt
;; XFree86
(defun my-c-xfree()
  (interactive)
  (setq c-default-style "user"
        c-basic-offset 4))

(defun my-c-emacs()
  (interactive)
  (setq c-default-style "user"
        c-basic-offset 2))


(defun my-c-sf()
  (interactive)
  (setq c-default-style "user"
        c-basic-offset 3))

;; linux:
;; TABS, not spaces!
;; 8 


;; patches:  -p !



(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-state 1))) ;see /a in modeline

;c-mode-hook


(add-hook 'c-mode-hook
	  (lambda ()
	    (set (make-variable-buffer-local 'outline-regexp) "[^#\n
 	{}]")
            (define-key c-mode-base-map (kbd "C-m") 'c-context-line-break)
            ))

(add-hook 'c++-mode-hook
	  (lambda ()
	    (set (make-variable-buffer-local 'outline-regexp) "[^#\n
 	{}]")))



;;; it sets the hooks !!
(require 'xcscope)
(add-hook 'gdb-mode-hook (function cscope:hook))
(add-hook 'gdb-mode-hook
	  (lambda ()
	    (make-local-variable 'cscope-initial-directory)))

;cscope-command-args
(set-default 'cscope-command-args (list "-R"))

(defvar my-cscope-map (lookup-key cscope:map  (kbd "\C-cs")) "down w/ that prefix")

(define-key my-cscope-map "/" 'cscope-set-initial-directory)
(global-set-key [(control ?#)] my-cscope-map)

(add-hook 'gdb-mode-hook (function cscope:hook))
;; QT
; http://doc.trolltech.com/3.0/qkeyevent.html


;;; cscope

;; often the variable .... database is inherited from another buffer ... wrong !!
;; cscope-search-one-database
(setq cscope-display-cscope-buffer nil)
(setq cscope-do-not-update-database 't)

(require 'etags)
(defun mmc-find-tag(&optional prefix)
  "union of `find-tag' alternatives. decides upon major-mode"
  (interactive "P")
  (if (and (boundp 'cscope-minor-mode)
           cscope-minor-mode)
      (progn
        (ring-insert find-tag-marker-ring (point-marker))
	;; (push-tag-mark)
        (setq cscope-display-cscope-buffer prefix)
        (call-interactively
         (if prefix
             'cscope-find-this-symbol
           'cscope-find-global-definition-no-prompting
           )))
    (call-interactively 'find-tag)))

(substitute-key-definition 'find-tag 'mmc-find-tag global-map)


(font-lock-add-keywords
  'c-mode
  '(("set_frame_shapes" 0 font-lock-builtin-face))
  '(("mmc:" 0 font-lock-builtin-face))
  )



(when nil
  (aget font-lock-keywords-alist 'c-mode)

  (setq font-lock-keywords-alist
	(aput 'font-lock-keywords-alist 'c-mode '()))
  (setq font-lock-keywords-alist
	(cdr font-lock-keywords-alist))
  )


(require 'ffap)
(add-to-list 'ffap-c-path "~/sc/gauche/.gl/include/")
(add-to-list 'ffap-c-path "/p/postgresql-8/work/pgsql-server/src/include/")

(add-to-list 'ffap-c-path "/usr/include/apache2/")
(add-to-list 'ffap-c-path "/usr/include/postgresql/")

(add-to-list 'ffap-c-path "/usr/include/gtk-2.0/")
(add-to-list 'ffap-c-path "/usr/lib/gauche/0.8.10/include/")
(add-to-list 'ffap-c-path "/usr/lib/gauche/0.9/include/")
;; ffap-c-path
(set-default 'ffap-c-path
	     (cons "/usr/lib/gauche/0.9/include/" ffap-c-path))

;; when adding at late run-time:
;; (setq-default ffap-c-path ffap-c-path)


(add-to-list 'ffap-c-path "/usr/include/X11")
(add-to-list 'ffap-c-path "/usr/include/gtksourceview-1.0/")
(add-to-list 'ffap-c-path "/usr/include/gtkextra-2.0/")

(add-to-list 'ffap-c-path "/usr/include/libart-2.0/")
(add-to-list 'ffap-c-path "/usr/include/libgnome-2.0/")

;;  make the var buffer local  huh????


(require 'mmc-syntax)




;;; tabs
                                        ; in xfree, 
(defun file-under-p (path root)
  ""
  (string-match (concat "^" (regexp-quote (expand-file-name root))) (expand-file-name path)))



(defun kaz-c-mode-common-hook ()
  (abbrev-mode 1)
  (setq indent-tabs-mode nil)
  (define-key c-mode-base-map "\C-m"  'c-context-line-break)
  (if
      (or
       ;; i spent some time re-indenting C sources (librep, xfree). i realized that it was due to my self-imposed tab=4
       ;; so, for these sources i have to accept their standard:
       (file-under-p (buffer-file-name (current-buffer)) "/p/xfree-4.3.0-r1_experimental/work/xc/")
       (file-under-p (buffer-file-name (current-buffer)) "/p/")
       )
      (setq tab-width 8)))

(add-hook 'c-mode-common-hook         'kaz-c-mode-common-hook)




(defun elinks (url)
  ""
  (xterm nil (format "elinks %s" url)))

;; (elinks "www.wsws.org")

(defun gtk-doc (symbol)
  "grab the symbol under the point (interpret it as a gtk+ function name),
and invoke a html browser to display the relevant API docs  "
  (interactive (list (thing-at-point 'symbol)))
  (if (string-match "-" symbol)
      (setq symbol (replace-regexp-in-string "-" "_" symbol)))
  (cond
   ((string-match "^q" symbol)
    (elinks
     (compose-path "file:///opt/qt-4.7.0-beta1/doc/html"
		   (concat (downcase symbol) ".html"))))
   (t; else
    (xterm nil (format "gnome-doc %s" symbol) symbol))))

;;(call-process "/x/activity/shell/gtk" nil nil nil symbol)

(defun invert-word-separator (start end)
  (interactive "r")
  ;; find-out in what direction (- -> _  or reverse)
  (save-excursion
    (goto-char start)
    (let* ((lispy (search-forward "_" end 't)) ; do we want lispy now ?
           (from (if lispy "_" "-"))
           (to (if lispy "-" "_")))
      (do-replace-string from to nil start end))))


(defun lispy-name-2-camelcase (start end)
  (interactive "r")
  (save-excursion
    (upcase-initials-region start end)
    (do-replace-string "-" "" nil start end)))

;; reverse ?

(defun camelcase-2-lispy-name (start end)
  (interactive "r")
  (save-excursion
    (let ((case-fold-search nil))
      (while (search-forward-regexp "[[:upper:]]" end 't)
        (downcase-region
         (match-beginning 0)
         (match-end 0))
        (goto-char (match-beginning 0))
        (insert "-")
        (goto-char (+ (match-end 0) 1))))))

        
(global-set-key [(alt ?-)] 'invert-word-separator)
(global-set-key [(alt ?.)] 'gtk-doc)

; c-mode-hook


(copy-face 'font-lock-th-face 'font-lock-string-face)
(require 'mmc-gud)



;; kernel & gnome:
(setq
 indent-tabs-mode t
 c-basic-offset 8
 tab-width 8)



;;; Electricity.

;; mmc:
;; comparison with emacs/23.1/lisp/progmodes/cc-cmds.el.gz
;; last-command-event vs. last-command-char ??
;; 'no-space-before-funcall in c-cleanup-list -> remove it when found.
(defun c-electric-paren (arg)
  "Insert a parenthesis.

If `c-syntactic-indentation' and `c-electric-flag' are both non-nil, the
line is reindented unless a numeric ARG is supplied, or the parenthesis
is inserted inside a literal.

Whitespace between a function name and the parenthesis may get added or
removed; see the variable `c-cleanup-list'.

Also, if `c-electric-flag' and `c-auto-newline' are both non-nil, some
newline cleanups are done if appropriate; see the variable `c-cleanup-list'."
  (interactive "*P")
  (let ((literal (c-save-buffer-state () (c-in-literal)))
	;; shut this up
	(c-echo-syntactic-information-p nil))
    (self-insert-command (prefix-numeric-value arg))

    (if (and (not arg) (not literal))
	(let* (	;; We want to inhibit blinking the paren since this will
	       ;; be most disruptive.  We'll blink it ourselves
	       ;; afterwards.
	       (old-blink-paren blink-paren-function)
	       blink-paren-function)
	  (if (and c-syntactic-indentation c-electric-flag)
	      (indent-according-to-mode))

	  ;; If we're at EOL, check for new-line clean-ups.
	  (when (and c-electric-flag c-auto-newline
		     (looking-at "[ \t]*\\\\?$"))

	    ;; clean up brace-elseif-brace
	    (when
		(and (memq 'brace-elseif-brace c-cleanup-list)
		     (eq last-command-char ?\()
		     (re-search-backward
		      (concat "}"
			      "\\([ \t\n]\\|\\\\\n\\)*"
			      "else"
			      "\\([ \t\n]\\|\\\\\n\\)+"
			      "if"
			      "\\([ \t\n]\\|\\\\\n\\)*"
			      "("
			      "\\=")
		      nil t)
		     (not  (c-save-buffer-state () (c-in-literal))))
	      (delete-region (match-beginning 0) (match-end 0))
	      (insert-and-inherit "} else if ("))

	    ;; clean up brace-catch-brace
	    (when
		(and (memq 'brace-catch-brace c-cleanup-list)
		     (eq last-command-char ?\()
		     (re-search-backward
		      (concat "}"
			      "\\([ \t\n]\\|\\\\\n\\)*"
			      "catch"
			      "\\([ \t\n]\\|\\\\\n\\)*"
			      "("
			      "\\=")
		      nil t)
		     (not  (c-save-buffer-state () (c-in-literal))))
	      (delete-region (match-beginning 0) (match-end 0))
	      (insert-and-inherit "} catch (")))

	  ;; Check for clean-ups at function calls.  These two DON'T need
	  ;; `c-electric-flag' or `c-syntactic-indentation' set.
	  ;; Point is currently just after the inserted paren.
	  (let (beg (end (1- (point))))
	    (cond

	     ;; space-before-funcall clean-up?
	     ((and (or (memq 'space-before-funcall c-cleanup-list)
		       (memq 'no-space-before-funcall c-cleanup-list))
		   (eq last-command-char ?\()
		   (save-excursion
		     (backward-char)
		     (skip-chars-backward " \t")
		     (setq beg (point))
		     (and (c-save-buffer-state () (c-on-identifier))
                          ;; Don't add a space into #define FOO()....
                          (not (and (c-beginning-of-macro)
                                    (c-forward-over-cpp-define-id)
                                    (eq (point) beg))))))
	      (save-excursion
		(delete-region beg end)
		(goto-char beg)
		(unless (memq 'no-space-before-funcall c-cleanup-list)
		  (insert ?\ ))))

	     ;; compact-empty-funcall clean-up?
		  ((c-save-buffer-state ()
		     (and (memq 'compact-empty-funcall c-cleanup-list)
			  (eq last-command-char ?\))
			  (save-excursion
			    (c-safe (backward-char 2))
			    (when (looking-at "()")
			      (setq end (point))
			      (skip-chars-backward " \t")
			      (setq beg (point))
			      (c-on-identifier)))))
		   (delete-region beg end))))
	  (and (eq last-input-event ?\))
	       (not executing-kbd-macro)
	       old-blink-paren
	       (funcall old-blink-paren))))))

(require 'mmc-c-styles)
(provide 'mmc-c-mode)
