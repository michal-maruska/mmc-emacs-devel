;; cc-mode.el

;; gnome

(require 'mmc-font-lock)

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

(defun mmc-find-tag(&optional prefix)
  "union of `find-tag' alternatives. decides upon major-mode"
  (interactive "P")
  (if (and (boundp 'cscope-minor-mode)
           cscope-minor-mode)
      (progn
        ;; (ring-insert find-tag-marker-ring (point-marker))
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


(add-to-list 'ffap-c-path "/usr/X11R6/include/")
(add-to-list 'ffap-c-path "/usr/include/X11")
(add-to-list 'ffap-c-path "/usr/include/gtksourceview-1.0/")
(add-to-list 'ffap-c-path "/usr/include/gtkextra-2.0/")

(add-to-list 'ffap-c-path "/usr/include/libart-2.0/")
(add-to-list 'ffap-c-path "/usr/include/libgnome-2.0/")

;;  make the var buffer local


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
      (replace-string from to nil start end))))


(defun lispy-name-2-camelcase (start end)
  (interactive "r")
  (save-excursion
    (upcase-initials-region start end)
    (replace-string "-" "" nil start end)))

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


(provide 'mmc-c-mode)
