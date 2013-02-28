
(require 'cc-mode)

;; so these don't set/use c-basic-offset ??
;; (set to 2 or 4). Maybe inherit from ...?

;; c-basic-offset     ... how much spaces + c-offsets-alist
;; indent-tabs-mode   ... use `TAB-compression' JZW
;;
;; (setq tab-width 4) ... tab char in the file:


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
				  defun-close-semi))
   ;;
   (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
				  (substatement-open . 0)
				  (case-label        . 4)
				  (block-open        . 0)
				  (knr-argdecl-intro . -)))
   (c-echo-syntactic-information-p . t)))



(c-add-style
 "tomtom"
 '((c-tab-always-indent        . t)	; TAB just indents
   ;;c-basic-offset
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
				  defun-close-semi))
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
				  defun-close-semi))
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
				  defun-close-semi))
   ;;
   (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
				  (substatement-open . 0)
				  (case-label        . 4)
				  (block-open        . 0)
				  (knr-argdecl-intro . -)))
   (c-echo-syntactic-information-p . t)))



(require 'cc-guess)
(defun tomtom-hook ()
  ""
  (interactive)
  ;; when loading & saving
  (setq tab-width 8
  ;;
  ;; when indenting myself:
	;; c-basic-offset 8
	)
  (c-guess-buffer)

  ;; mmc: for TomTom I need to include the NDK from Perforce.
  ;; make-variable-buffer-local
  (make-local-variable 'ffap-c-path)
  (add-to-list 'ffap-c-path
	       (concat
		"/home/michal/perforce/platform/android/main/mydroid/ndk"
		"/build/prebuilt/linux-x86/arm-eabi-4.4.0/arm-eabi/"
		"include/c++/4.4.0/")))


(provide 'mmc-c-styles)

