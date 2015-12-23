;; (java-find-class/package "com.android.internal.util.StateMachine")

;; find-line-by-string
(require 'mmc-cscope)

;; file-under-p
(require 'mmc-simple)

(defun java-find-module-in-cscope (symbol cscope-files-file root &optional extension)
  ;; Find a possible filename in cscope.files, which could carry the definition of
  ;; symbol ... java Class name. x.y.z -> either x/y/z  or x/y file.
  ;; @extension
  (save-excursion
    (let ((relative
	   (concat  "/"
		    (add-suffix-optionally
		     (translate-module-to-filename symbol "\\.")
		     (or extension ".java")))))
      (aif found
	   (or (find-line-by-string relative cscope-files-file)
	       (find-line-by-string
		;; a/b.java -> a.java:
		;; sometimes it's an internal class:
		;; it's not in the `import' statement, but used directly!
		;; like:
		;; import a;
		;; x = new a.b.d();
		;;
		(concat (substring (file-name-directory relative) 0 -1)
			(or extension ".java"))
		cscope-files-file))
	   (concat root found)
	   nil))))


(defun java-find-class/package (symbol)
  "ffap implementation to use ...."
  (let ((cwd (file-name-directory (buffer-file-name))))
    (cond
     ((file-under-p cwd "~/italia")
      (or
       (java-find-module-in-cscope symbol
				   "~/italia/cscope.files.java"
				   "~/italia/")
       (java-find-module-in-cscope symbol
				   "~/italia/cscope.files.java"
				   "~/italia/" ".aidl")))

     ((file-under-p cwd "~/gallo")
      (or
       (java-find-module-in-cscope symbol
				   "~/gallo/cscope.files.java"
				   "~/gallo/")
       (java-find-module-in-cscope symbol
				   "~/gallo/cscope.files.java"
				   "~/gallo/" ".aidl")))


     ((or (file-under-p cwd "~/next")
	  (file-under-p cwd "/home/maruska/next")
	  (file-under-p cwd "~/nav4/")
	  )
      (java-find-module-in-cscope symbol
				  "~/nav4/cscope.files.java"
				  "~/nav4/"))
     (t
      nil))))

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
