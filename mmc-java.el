;; (java-find-class/package "com.android.internal.util.StateMachine")


;; file-under-p find-line-by-string
(require 'mmc-simple)

(defun file-name-directory-no/ (filename)
  "drop the separator as well."
  (substring (file-name-directory filename) 0 -1))

(defun java-find-module-in-cscope (symbol cscope-files-file root &optional extension)
  "Find a possible filename in cscope.files, which could carry the definition of
  symbol ... java Class name. x.y.z -> either x/y/z  or x/y file.
  ;; @extension"
  (save-excursion
    (let ((relative-class-file-path
           (concat  "/"
                    (add-suffix-optionally
                     (translate-module-to-filename symbol "\\.")
                     (or extension ".java")))))
      (aif found
           (or (find-line-by-string relative-class-file-path cscope-files-file)
               ;; try to find class x.y as `internal-class' y inside class x.
               (let ((outer-class (file-name-directory-no/ relative-class-file-path)))
                 (if (string= "" outer-class)
                     nil
                   (find-line-by-string
                    ;; a/b.java -> a.java:
                    ;; sometimes it's an internal class:
                    ;; it's not in the `import' statement, but used directly!
                    ;; like:
                    ;; import a;
                    ;; x = new a.b.d();
                    ;;
                    (concat outer-class
                            (or extension ".java"))
                    cscope-files-file))))
           (compose-path root found)
           nil))))



;; fixme: drop-prefix
(defun find-in-cscope-files (symbol cscope-file-dir &optional prefix)
  "return filename related to class @symbol, in cscope in given directory."
  (let ((cscope-base-file "cscope.files.java"))
    (if (not prefix)
        (setq prefix cscope-file-dir))
    (or
     (java-find-module-in-cscope symbol
                                 (compose-path cscope-file-dir cscope-base-file)
                                 prefix)
     (java-find-module-in-cscope symbol
                                 (compose-path cscope-file-dir cscope-base-file)
                                 prefix ".aidl"))))

(defun java-find-class/package (symbol)
  "ffap implementation to use ...."
  (let ((cwd (file-name-directory (buffer-file-name))))
    (cond
     ((file-under-p cwd "~/italia")
      (find-in-cscope-files symbol "~/italia"))

     ((file-under-p cwd "~/gallo")
      (find-in-cscope-files symbol "~/gallo"))

     ((or (file-under-p cwd "~/next")
          (file-under-p cwd "/home/maruska/next")
          (file-under-p cwd "~/nav4/"))
      (find-in-cscope-files symbol
                            "~/nav4/"))
     ;; aif =>
     ((file-under-p cwd "~/n4f/nav4-features")
      (or
       (find-in-cscope-files symbol "~/n4f/nav4-features")
       (find-in-cscope-files symbol "~/nav4/" "~/nav4/")))

     ((file-under-p cwd "~/n4f/pnd-navkit")
      (or
       (find-in-cscope-files symbol "~/n4f/pnd-navkit")
       (find-in-cscope-files symbol "~/nav4/" "~/nav4/")))

     (t
      nil))))

(require 'rx)

;; fixme: recognize constructor !!! w/o return type!
;; defconst
(setq my-java-outline-regexp
  ;; " *(public|private|void)"
  (rx
   (or
    (group				;shy-group
     (or
      (sequence				;\\([ 	]*.*
       (0+ space)
       (0+ (sequence (or "final" "private" "public" "static") (1+ space)))
       (or "class" "interface")
       (1+ space)
       (1+ alphanumeric)		;[a-zA-Z0-9_]
       (0+ (or space "\n"))
       (? (or "extends"  "implements"))
       )				;\\({\\|extends\\|implements\\)\\)

      ;; methods
      (sequence
       (0+ space)
       ;; modifiers:
       (0+
        (sequence
         (or
          "public" "protected" "private" "static" "final" "native"
          "transient" "volatile" "strict" "synchronized")
         space))
                                        ;(0+ space)
       ;; return type  "void"
       (sequence
        ;; fixme: not  `for' `if' `switch'...
        (1+ alphanumeric)
        ;; ArrayType[]
        (? "[]")
        (0+ space))

       (1+ space)

       ;; name
       (1+ alphanumeric)
                                        ; (0+ space)
       "("
       (? ")")
       )))
    (group
     (0+ space)
     "/**"
     )
    ))
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
)

(defun my-java-mode-hook ()
  ""
  (my-c-mode-hook)
  ;; how to hide/show ??
  ;;(setq buffer-invisibility-spec '((hs . t) (hs . t) t))
  (setq buffer-invisibility-spec 't)
  (set (make-local-variable 'outline-regexp)
       my-java-outline-regexp)
  (push                                 ;'(defun-open after)
   '(inline-open after)
   c-hanging-braces-alist))

(when nil
  (c-hanging-braces-alist     . ((substatement-open after)
                                  (brace-list-open)
                                  (defun-open after)
                                  (inline-open after)
                                  ))
  )

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
