(require 'cc-mode)
(require 'assoc)

;; so these don't set/use c-basic-offset ??
;; (set to 2 or 4). Maybe inherit from ...?

;; 2013/5  so, C-style talks about + - skips; those
;; are relative to/in units of "c-basic-offset spaces"
;; then spaces/tab is dependent (like I/O)
;; on indent-tabs-mode and tab-width.
;;
;; c-basic-offset     ... how much spaces + c-offsets-alist
;; indent-tabs-mode   ... use `TAB-compression' JZW
;;
;; (setq tab-width 4) ... tab char in the file: (the compression factor)

;; (c-get-style-variables "gnu")
;; c-style-alist
;; c-style-variables
;;  c-indentation-style -- internal.
;; c-cleanup-list  .. todo!

;; (c-set-style

;; modify the "Linux" style to insert <TAB>s !

;; c-insert-tab-function     tab-to-tab-stop
;; indent-tabs-mode          t

;; make it insert TABs!
;; (aget (aget c-style-alist "linux") 'indent-tabs-mode)

;; This rewrites the upstream linux style!
(let ((l (aget c-style-alist "linux")))
  (unless (aget l 'indent-tabs-mode)
    ;; (x y ...) -> (x Z y ...)
    (setcdr l
        (cons
         '(indent-tabs-mode . t)
         (cdr l)))))

;; paren-brace:  "){" -> ") {"
;; with newline in between?
(let* ((l (aget c-style-alist "linux"))
       (cleanup (aget l 'c-cleanup-list)))
  (unless
      (memq 'paren-brace cleanup)
    (setcdr cleanup
        (cons
         'paren-brace
         (cdr cleanup)))))
;; (add-to-list 'c-cleanup-list 'paren-brace)


(c-add-style
 "tomtom"
;; (setq indent-tabs-mode t)
 '((c-tab-always-indent        . t)	; TAB just indents
   (c-basic-offset . 8)
   (c-comment-only-line-offset . 0)	; only comment -> additional offset

   ;;
   (c-hanging-braces-alist     . ((substatement-open after)
				  (brace-list-open)))
   (c-hanging-colons-alist     . ((member-init-intro before)
				  (inher-intro)
				  (case-label after)
				  (label after)
				  (access-label after)))
   (c-cleanup-list             . (scope-operator
				  no-space-before-funcall
				  empty-defun-braces
				  defun-close-semi
				  ;; if ()_{
				  paren-brace
				  ))
   ;; C++ so
   (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
				  (substatement-open . 0)
				  (case-label        . 4)
				  (block-open        . 0)
				  (knr-argdecl-intro . -)

				  ;; namespace-open
				  ;; innamespace  .... ignore it!
				  (substatement  . 2)
				  (statement-block-intro . 2)
				  (innamespace . 0)
				  (inline-open 0)
				  (inclass . 2)
				  (defun-block-intro . 2)
				  (label . 0)

				  ;; problem:  if a b; else c;    if after b we have ";" then
				  ;; relative to "if", otherwise relative to  "b" !!
				  ;;
				  ;; 2011-02-24 for some reason I had -2
				  ;; but
				  (else-clause 0)
				  (topmost-intro-cont 0)
				  (access-label . -2) ; - inclass
				  (topmost-intro . 0)
				  (case-label . 0)
				  (statement-case-intro . 2)
				  (member-init-intro . 2)))

   (c-echo-syntactic-information-p . t)))


(c-add-style
 "dui"
 '((c-cleanup-list             . (no-space-before-funcall
				  brace-else-brace))))

(c-add-style
 "xorg"
 '((c-tab-always-indent        . t)	; TAB just indents
   ;;c-basic-offset
   (c-comment-only-line-offset . 0)	; only comment -> additional offset

   (c-hanging-braces-alist     . ((substatement-open after)
				  (brace-list-open)))
   (c-hanging-colons-alist     . ((member-init-intro before)
				  (inher-intro)
				  (case-label after)
				  (label after)
				  (access-label after)))
   (c-cleanup-list             . (scope-operator
				  no-space-before-funcall
				  empty-defun-braces
				  defun-close-semi
				  paren-brace))
   ;;
   (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
				  (substatement-open . 0)
				  (case-label        . 4)
				  (block-open        . 0)
				  (knr-argdecl-intro . -)))
   (c-echo-syntactic-information-p . t)))



(c-add-style
 "rxvt"
 '((c-tab-always-indent        . t)	; TAB just indents
   ;;c-basic-offset
   (c-comment-only-line-offset . 0)	; only comment -> additional offset

   (c-hanging-braces-alist     . ((substatement-open after)
				  (brace-list-open)))
   (c-hanging-colons-alist     . ((member-init-intro before)
				  (inher-intro)
				  (case-label after)
				  (label after)
				  (access-label after)))
   (c-cleanup-list             . (scope-operator
				  no-space-before-funcall
				  empty-defun-braces
				  defun-close-semi
				  paren-brace))
   ;;
   (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
				  (substatement-open . 0)
				  (case-label        . 4)
				  (block-open        . 0)
				  (knr-argdecl-intro . -)))
   (c-echo-syntactic-information-p . t)))



;; testbed:
(c-add-style
 "mmctest"
 '((c-tab-always-indent        . t)	; TAB just indents
   ;;c-basic-offset
   (c-comment-only-line-offset . 0)	; only comment -> additional offset

   (c-hanging-braces-alist     . ((substatement-open after)
				  (brace-list-open)))
   (c-hanging-colons-alist     . ((member-init-intro before)
				  (inher-intro)
				  (case-label after)
				  (label after)
				  (access-label after)))
   (c-cleanup-list             . (scope-operator
				  ;; funny:
				  space-before-funcall
				  empty-defun-braces
				  defun-close-semi
				  paren-brace))
   ;;
   (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
				  (substatement-open . 0)
				  (case-label        . 4)
				  (block-open        . 0)
				  (knr-argdecl-intro . -)))
   (c-echo-syntactic-information-p . t)))



(require 'cc-guess nil 'noerror)

(defmacro add-to-list-list (symbol &rest elements)
  ""
  `(set ,symbol (append (symbol-value ,symbol)
			(list ,@elements))))


;; see mmc-c-mode.el for cscope-based solution: todo: cron -> reindex!
(defun decide-for-c-include-path ()
  "Extend `FFAP' paths list for a C-mode,
based on filename."
  (cond
   ((string-match "next/kernel/" (buffer-file-name))
    (add-to-list 'ffap-c-path
		 "~/next/kernel/include"))

   ((string-match "spark/linux-2.6.28.10/" (buffer-file-name))
    (add-to-list 'ffap-c-path
		 "~/perforce/spark/linux-2.6.28.10/include"))

   ((string-match "italia/" (buffer-file-name))
    ;; fixme: only for italia. see ...
    ;; fixme: todo: shared variable ....
    (make-local-variable 'ffap-c-path)
    (add-to-list-list 'ffap-c-path
		 "~/italia/frameworks/native/include/" ;utils/Log.h
		 "~/italia/system/core/include/"
					;"~/perforce/spark/linux-2.6.28.10/include"
		 ))

   ((or (string-match "nav4/" (buffer-file-name))
	(string-match "next/" (buffer-file-name)))
    (make-local-variable 'ffap-c-path)
    (add-to-list-list
     'ffap-c-path
     "~/nav4/frameworks/native/include/" ;utils/Log.h
     "~/nav4/system/core/include/"
     "~/nav4/frameworks/base/include/"))))


(defun tomtom-hook ()
  "adapt to tomtom style for C"
  (interactive)
  ;; when loading & saving
  (setq indent-tabs-mode t)
  (setq tab-width 8
	;; when indenting myself:
	;; c-basic-offset 8
	)
  (if (functionp 'c-guess-buffer)
      (c-guess-buffer)))



(defun my-c-mode-hook ()
  "Common part for C and C++ modes."
					;(electric)
  ;; simple; anything starting the line but these:
  (setq outline-regexp "[^{} \t#\n]")
  ;; what? add or remove the space in  "f (x)"?
  (require 'mmc-c-mode-patches)
  (add-to-list 'c-cleanup-list
	       'no-space-before-funcall
	       ;'space-before-funcall
	       )
					;brace-else-brace
  ;; force the C++ mode:
  (if (and (or
	    (string-match "fork-plugin/src/.*\\.h" (buffer-file-name))
	    (string-match "/perforce/" (buffer-file-name)))
	   (not (eq major-mode 'c++-mode)))
      (c++-mode)
    (decide-c-style-by-path))
  (decide-for-c-include-path))

(defun decide-c-style-by-path ()
  "The part which comes after possibly forcing C++ mode.
Decide for a style, based on path."
  ;; avoid duplication, so exit immediately.
  (let* ((name (buffer-file-name))
	 (style
	  (if name
	      (cond
	       ((string-match "/usr/src/linux" name)
		"linux")
	       ((string-match "/xorg/" name)
		"xorg")
	       ((string-match "/x/" name)
		"xorg")
	       ((string-match "/fork-plugin/src/" name)
		"xorg")

	       ((string-match "/sawfish/" name)
		"rxvt")

	       ((string-match "/linux-2.6" name)
		"linux")

	       ((or (string-match "/perforce/" name)
		    (string-match "/ngl/" name)

		    (string-match "/next/" name)
		    (string-match "/italia/" name)
		    (string-match "/nav4/" name)
		    (string-match "/gallo/" name)
		    (string-match "/n4f/" name)
		    )
		;; /home/maruska/ngl/project/arizona2/main/CrossPlatform/
		;; Framework/PlatformAbstractionLayer/Implementation/DeviceInformation/
		"tomtom")
	       (t
					;"free-group-style"
		nil))
	    nil)))
    (when style
      (c-set-style style)
      ;; ~/git/xorg/xserver/xkb/freeze-stack.c
      (if (string= style "tomtom")
	  (tomtom-hook))
      )))
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)

(provide 'mmc-c-styles)

