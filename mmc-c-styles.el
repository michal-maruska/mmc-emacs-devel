(require 'cc-mode)
(require 'assoc)
;; so these don't set/use c-basic-offset ??
;; (set to 2 or 4). Maybe inherit from ...?

;; c-basic-offset     ... how much spaces + c-offsets-alist
;; indent-tabs-mode   ... use `TAB-compression' JZW
;;
;; (setq tab-width 4) ... tab char in the file:

;; (c-get-style-variables "gnu" )
;; (c-style-alist )
;; (c-style-variables
;;  c-cleanup-list)
;; c-set-style
;; c-indentation-style


;; modify the "Linux" style to instert <TAB>s !
;; Why?

;; c-insert-tab-function     tab-to-tab-stop
;; indent-tabs-mode          t

;; make it insert TABs!
;; (aget (aget c-style-alist "linux") 'indent-tabs-mode)

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

(defun tomtom-hook ()
  ""
  (interactive)
  ;; when loading & saving
  (setq indent-tabs-mode t)
  (setq tab-width 8
  ;;
  ;; when indenting myself:
	;; c-basic-offset 8
	)
  (if (functionp 'c-guess-buffer)
      (c-guess-buffer))

  ;; mmc: for TomTom I need to include the NDK from Perforce.
  ;; make-variable-buffer-local
  (make-local-variable 'ffap-c-path)
  (add-to-list 'ffap-c-path
	       (concat
		"~/italia/"
		"system/core/include/"))
  (add-to-list 'ffap-c-path
	       (concat
		"/home/michal/perforce/platform/android/main/mydroid/ndk"
		"/build/prebuilt/linux-x86/arm-eabi-4.4.0/arm-eabi/"
		"include/c++/4.4.0/")))


(provide 'mmc-c-styles)

