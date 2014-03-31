;; (java-find-class/package "com.android.internal.util.StateMachine")


(defun find-line-by-string (string filename)
  ""
  (with-current-buffer (find-file-noselect filename 'nowarn 'rawfile)
    ;; (set-buffer buffer)
    (goto-char (point-min))
    ;; at end of line
    (if (search-forward relative)
	;; buffer-substring-no-properties
	(erase-text-properties (line-string))
      nil)))

(defun java-find-class/package (symbol)
  "ffap implementation to use ...."
  (save-excursion
    (let ((relative (add-suffix-optionally
		     (translate-module-to-filename symbol "\\.") ".java")))
      (concat
       ;"~/next/"
       "~/italia/"
       ;; ~/next/cscope.files.java
	      (find-line-by-string relative "~/italia/cscope.files.java")))))

(require 'rx)

(defun my-java-mode-hook ()
  ""
  ;; how to hide/show ??
  ;;(setq buffer-invisibility-spec '((hs . t) (hs . t) t))
  (setq buffer-invisibility-spec 't)
  (set (make-local-variable 'outline-regexp)
       ;; " *(public|private|void)"
       (rx
	(group				;shy-group
	 (or
	  (sequence			;\\([ 	]*.*
	   (0+ space)
	   (0+ (sequence (or "final" "private" "public" "static") (1+ space)))
	   (or "class" "interface")
	   (1+ space)
	   (1+ alphanumeric)		;[a-zA-Z0-9_]
	   (0+ (or space "\n"))
	   (? (or "extends"  "implements"))
	   )				;\\({\\|extends\\|implements\\)\\)

	  (sequence
	   (0+ space)
	   ;; modifiers:
	   (1+
	    (sequence
	     (or
	      "public" "protected" "private" "static" "final" "native"
	      ;; "synchronized"
	      "transient" "volatile" "strictfp"
	      ) space))
	   (0+ space)
	   ;; return type  "void"
	   (1+ alphanumeric)
	   (0+ space)
	   ;; name
	   (1+ alphanumeric)
	   (0+ space)
	   "("
	   )))))

  ;; still missing:
;; 	   \\(
;;    \\([a-zA-Z0-9_]
;;       \\|
;;       \\( *	*< *	*\\)
;;       \\|
;;       \\( *	*> *	*\\)
;;       \\|
;;       \\( *	*, *	*\\)
;;       \\|
;;       \\( *	*\\[ *	*\\)
;;       \\|
;;       \\(]\\)
;;    \\)+
;; \\)
;; [ 	]+[a-zA-Z0-9_]+[ 	]*(\\(.*\\))
  ;;                             `^' this is it! mmc!
;; [ 	]*\\(throws[ 	]+\\([a-zA-Z0-9_, 	\n]*\\)\\)?[ 	\n]*{
;; \\)"



;;; the original regexp split:
;; "\\(?:
;; ...is the "shy group" construct
;; final
;; \\([ 	]*.*\\(class\\|interface\\)[ 	]+[a-zA-Z0-9_]+[ 	\n]*\\({\\|extends\\|implements\\)\\)

;; \\|
;; [ 	]*\\(public\\|private\\|static\\|final\\|native\\|synchronized\\|transient\\|volatile\\|strictfp\\| \\|	\\)*[ 	]+
;;                                  ^
;; \\(
;;    \\([a-zA-Z0-9_]
;;       \\|
;;       \\( *	*< *	*\\)
;;       \\|
;;       \\( *	*> *	*\\)
;;       \\|
;;       \\( *	*, *	*\\)
;;       \\|
;;       \\( *	*\\[ *	*\\)
;;       \\|
;;       \\(]\\)
;;    \\)+
;; \\)
;; [ 	]+[a-zA-Z0-9_]+[ 	]*(\\(.*\\))
;; [ 	]*\\(throws[ 	]+\\([a-zA-Z0-9_, 	\n]*\\)\\)?[ 	\n]*{
;; \\)"

;;        "\\(?:\\([ \t]*.*\\(class\\|interface\\)[ \t]+[a-zA-Z0-9_]+[ \t\n]*\\({\\|extends\\|implements\\)\\)\\|[ \t]*\\(public\\|private\\|static\\|final\\|native\\|synchronized\\|transient\\|volatile\\|strictfp\\| \\|\t\\)*[ \t]+\\(\\([a-zA-Z0-9_]\\|\\( *\t*< *\t*\\)\\|\\( *\t*> *\t*\\)\\|\\( *\t*, *\t*\\)\\|\\( *\t*\\[ *\t*\\)\\|\\(]\\)\\)+\\)[ \t]+[a-zA-Z0-9_]+[ \t]*(\\(.*\\))[ \t]*\\(throws[ \t]+\\([a-zA-Z0-9_, \t\n]*\\)\\)?[ \t\n]*{\\)" )

  (setq c-basic-offset 4))

;; java-mode-hook
(add-hook 'java-mode-hook 'my-java-mode-hook)


;; ffap-alist
(add-to-list 'ffap-alist
	     '(java-mode . java-find-class/package))

(add-hook 'java-mode-hook 'cscope-minor-mode)
(add-hook 'java-mode-hook 'hs-minor-mode)

(add-to-list 'auto-mode-alist
	     '(".*.aidl" . java-mode))

(provide 'mmc-java)
