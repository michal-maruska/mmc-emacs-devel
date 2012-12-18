
;;; it sets the hooks !!
(require 'xcscope)

;; correct:
(defun cscope-minor-mode (&optional arg)
  ""
  (interactive "P")
  (progn
    (setq cscope-minor-mode (if (null arg) t (car arg)))
    (if cscope-minor-mode
	(progn
	  (easy-menu-add cscope:menu cscope:map)
	  (run-hooks 'cscope-minor-mode-hooks)))
    cscope-minor-mode))


(add-hook 'gdb-mode-hook (function cscope:hook))
(add-hook 'gdb-mode-hook
	  (lambda ()
	    (make-local-variable 'cscope-initial-directory)))

;cscope-command-args
;; http://cscope.sourceforge.net/large_projects.html
(set-default 'cscope-command-args (list "-R"))

(defvar my-cscope-map
  (lookup-key cscope:map (kbd "\C-cs")) "down w/ that prefix")

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

;; `find-tag-tag' is the function which gets the default symbol from the buffer, under the `point'.
;; And I changed it to NOT prompt, unless I ask for it.
;; in 2012 I started to use Tags for .... Makefile targets (in Android)? or what?
(defun mmc-find-tag-tag (string prompt-p)
  "Get a tag/symbol from under the point.
If prompt-p, then ask confirmation. With defaulting and completion."
  (let* ((completion-ignore-case (if (memq tags-case-fold-search '(t nil))
				     tags-case-fold-search
				   case-fold-search))
	 (default (funcall (or find-tag-default-function
			       (get major-mode 'find-tag-default-function)
			       'find-tag-default)))
	 (spec
	  (if (or (not default)
		  prompt-p)
	      (completing-read (if default
				   (format "%s (default %s): "
					   (substring string 0 (string-match "[ :]+\\'" string))
					   default)
				 string)
			       (tags-lazy-completion-table)
			       nil nil nil nil default)
	    "")))			; use default
    (if (equal spec "")
	(or default (user-error "There is no default tag"))
      spec)))


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
    ;(call-interactively 'find-tag)
    (find-tag (mmc-find-tag-tag "Find tag: " prefix) nil )))

(substitute-key-definition 'find-tag 'mmc-find-tag global-map)

