;;; `fontlock:'
(defconst scheme-font-lock-keywords-5
  (eval-when-compile
    (list
     ;; package/module language
     (list (concat "(\\(define\\*?\\("
		   ;; definitions
		   "\\(\\|-interface\\|-structure"
		   ;; Macro names, as variable names.  A bit dubious, this.
                   ;;  modules.
                   ;"\\|-module\\|-structure"		;mmc
		   "\\)\\)\\>"
		   ;; Any whitespace and declared object.
		   "[ \t]*(?"
		   "\\(\\sw+\\)?")
	   '(1 font-lock-keyword-face)
	   )))
  "Subdued expressions to highlight in Scheme modes.")



;; (list (concat "(\\(def\\("
;; 	      ;; Function declarations.
;; 	      "\\(advice\\|varalias\\|alias\\|generic\\|macro\\*?\\|method\\|"
;; 	      "setf\\|subst\\*?\\|un\\*?\\|"
;; 	      "ine-\\(condition\\|\\(?:derived\\|minor\\)-mode\\|"
;; 	      "method-combination\\|setf-expander\\|skeleton\\|widget\\|"
;; 	      "function\\|\\(compiler\\|modify\\|symbol\\)-macro\\)\\)\\|"
;; 	      ;; Variable declarations.
;; 	      "\\(const\\(ant\\)?\\|custom\\|face\\|parameter\\|var\\)\\|"
;; 	      ;; Structure declarations.
;; 	      "\\(class\\|group\\|package\\|struct\\|type\\)"
;; 	      "\\)\\)\\>"
;; 	      ;; Any whitespace and defined object.
;; 	      "[ \t'\(]*"
;; 	      "\\(setf[ \t]+\\sw+)\\|\\sw+\\)?")
;;       '(1 font-lock-keyword-face)
;;       '(9 (cond ((match-beginning 3) font-lock-function-name-face)
;; 		((match-beginning 6) font-lock-variable-name-face)
;; 		(t font-lock-type-face))
;; 	  nil t))





'(font-lock-remove-keywords 'scheme-mode
  '(("anchor" (0 cvs-marked-face) ("item" nil nil (0 diary-fac)))))




'(font-lock-remove-keywords 'scheme-mode
   '(("(define-c(proc|method|generic)\\(-fix\\)?\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 2 font-lock-function-name-face)))

;; (assq 'scheme-mode font-lock-keywords-alist)

(defun ++ (&rest args)
  (font-lock-add-keywords 'scheme-mode args))

(defun ++function (function-name)
  (font-lock-add-keywords 'scheme-mode ; args)
    ;;(++
    `((,(concat "(\\b" "\\("
		function-name "\\)" "\\b")
       1 font-lock-builtin-face))))

(defun -- (&rest args)
  (font-lock-remove-keywords 'scheme-mode args))




;;; mmc: Why remove?
'(font-lock-remove-keywords 'scheme-mode
   '(
    ;("add-method" 1 font-lock-keyword-face)
    ;("(with-cwd\\s-+\\s\"\\([^\\s\"]*\\)\\s\"" 1 font-lock-variable-name-face)
    ("(with-cwd\\s-+\\s\"\\([^\\s\"]*\\)\\s\"" 1 font-lock-variable-name-face 't)

    ("(with-cwd\\s-+\\s\"\\([^\\s\"]*\\)\\s\"" 1 font-lock-variable-name-face 'prepend)	;font-lock-def-face
    ("(with-cwd\\s-+\\s\"\\([^\\s\"]*\\)\\s\"" 1 font-lock-variable-name-face 'appen)	;font-lock-def-face

    ("(with-cwd\\s-+\\s\"\\([^\\s\"]*\\)\\s\"" 1 font-lock-variable-name-face 'prepend)
    ("(with-cwd\\s-+\\([^\\s\"]*\\)" 1 font-lock-variable-name-face 'append)
    ("\\<\\(FIXME|mmc|why\?\?\\):" 1 font-lock-warning-face prepend)

;    ))
    ("if-match" . font-lock-builtin-face)
    ("rxmatch-if" . font-lock-builtin-face)

    ("let-optionals" . font-lock-builtin-face)

    ("\\<\\(FIXME\\|mmc\\):" 1 font-lock-warning-face prepend)




    ("`\\(\\(\\s_\\)+\\)'" 1 cvs-marked-face)
    ("`\\(\\(\\s_\\|\\sw\\)+\\)'" 1 cvs-marked-face prepend)
    ("`\\(\\(\\s_\\)+\\)'" 1 cvs-marked-face prepend)

    ("\\<\\(FIXME\\):" 1 font-lock-warning-face prepend)
;    ("\\<\\(FIXME\\|mmc\\):" 1 font-lock-warning-face prepend)
    ("`\\(\\(\\s_\\|\\sw\\)+\\)'" 1 font-lock-keyword-face prepend)

    ("`\\(\\s_+\\)'" 1 font-lock-keyword-face)
    ("`\\(\\s_\\+\\)'" 1 font-lock-keyword-face)
    ("`\\(\\(\\s_\\|\\sw\\)+\\)'" 1 font-lock-keyword-face)
    ("`\\(\\(\\s_\\)+\\)'" 1 font-lock-keyword-face)
    ))


(when t                                 ;'define-font-lock
  ;;("(with-cwd\\s-+\\s\"\\([^\\s\"]*\\)\\s\"" 1 font-lock-variable-name-face 'prepend)	;font-lock-def-face
  ;;("(with-cwd\\s-+\\s\"\\([^\\s\"]*\\)\\s\"" 1 font-lock-variable-name-face 'prepend)	;font-lock-def-face
  ;;("(with-cwd\\s-+\\([^\\s\"]*\\)" 1 font-lock-variable-name-face 'append)	;font-lock-def-face

  (++ '("^(import-lambda-definition\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 1 font-lock-def-face))
  (++ '("^(external-lambda-definition\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 1 font-lock-def-face))


  (++ '("^(define-foreign\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 1 font-lock-def-face))



  ;; the `modules' language:
  (++ '("(define-structure\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 1 font-lock-def-face))
  (++ '("(define-interface\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 1 gnus-face-5))



  ;; named let:
  (++ '("(\\(let\\)\\s-+\\(\\(\\sw\\|\\s_\\)+\\)"
        (1 font-lock-keyword-face prepend)
        (2 font-lock-def-face)
        ))

                                        ;(-- '("(coroutine\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 1 font-lock-def-face))

  (++ '("(\\(coroutine\\)\\s-+" 1 font-lock-def-face))
                                        ;(-- '("(coroutine\\s-+" . font-lock-def-face))



  (++ '("(\\(define-record\\|make-record-type\\)\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 2 font-lock-def-face))
  (++ '("(\\(export\\)\\s-" 1 font-lock-keyword-face))
  (++ '("(\\(open\\)\\s-" 1 font-lock-keyword-face))
  (++ '("(\\(files\\)\\s-" 1 font-lock-keyword-face))

  (++ '("(with-cwd\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 1 font-lock-variable-name-face))
					;font-lock-variable-name-face
  (++ '("(with-cwd\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 1 font-lock-variable-name-face 'append)) ;font-lock-def-face


  (++ '("\\b\\(let1\\|receive\\)\\b"  1 font-lock-keyword-face))


  (++ '("\\b\\(export\\)\\b"  1 font-lock-def-face))
  (++ '("(\\(use\\|extend\\)\\b"  1  font-lock-builtin-face))


  (++ '("\\<\\(fixme\\|mmc\\|why\\?\\?\\):" 1 font-lock-warning-face prepend)) ; even in comments
  (++ '("\\(fixme\\|mmc\\|why\\):" 1 font-lock-warning-face 'prepend)) ; even in comments

  (++function "unless")
  (++function "when")

  (++ '("add-method" . font-lock-keyword-face)) ; no prepend !!
  (++function "if-match")
  (++ '("rxmatch-\\(if\\|let\\)" . font-lock-builtin-face))

  (++ '("`\\(\\(\\s_\\|\\sw\\)+\\)'" 1 font-lock-important prepend)) ;cvs-marked-face font-lock-keyword-face


  (++function "for-each-reverse")
  (++function "map-reverse")

  (++function "let-match")
  (++function "let-optionals")

  (++function "define-type")
  ;; fixme!
                                        ;(++ '("(define-cproc\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 1 font-lock-function-name-face))

  ;; mmc: class\\|
  (++ '("(define-c\\(?:proc\\|method\\|generic\\)\\(?:-fix\\)?\\s-+\\(\\(?:\\sw\\|\\s_\\)*\\)"
                                        ;"(define-c\\(class\\|proc\\|method\\|generic\\)\\(-fix\\)?\\s-+\\(\\(\\sw\\|\\s_\\)*\\)"
        1 font-lock-function-name-face))

  ;; fixme:  make the 2nd submatch colored too!
  (++ '("(define-entry (\\(\\(\\s_\\|\\sw\\)*\\)[ )]" 1 scheme-type/class/method-face))
  (++ '("(\\(define-entry\\) " 1 font-lock-def-face))

  (++ '("(define-element \\(\\(\\s_\\|\\sw\\)*\\)" 1 scheme-type/class/method-face))

  (++ '("(\\(define-element\\)" 1 font-lock-def-face))



  ;; scheme-type/class/method-face
  (++ '("define-form-parser\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 1 scheme-type/class/method-face))

  (++ '("(select-module\\s-+\\(\\(\\sw\\|\\s_\\)+\\)" 1 scheme-type/class/method-face))


  (--
   '(++ '("(define-c\\(?:class\\|proc\\|method\\|generic\\)\\(?:-fix\\)?\\s-+\\(\\(?:\\sw\\|\\s_\\)*\\)"
                                        ;"(define-c\\(class\\|proc\\|method\\|generic\\)\\(-fix\\)?\\s-+\\(\\(\\sw\\|\\s_\\)*\\)"
          1 scheme-type/class/method-face)))


  (++ '("(define-\\(?:method\\|generic\\)\\(?:-fix\\)?\\s-+\\(\\(?:\\sw\\|\\s_\\)*\\)"
                                        ;"(define-c\\(class\\|proc\\|method\\|generic\\)\\(-fix\\)?\\s-+\\(\\(\\sw\\|\\s_\\)*\\)"
        1 scheme-type/class/method-face))

  (++ '("(define-\\(?:method\\)\\s-+\\(\\(?:\\sw\\|\\s_\\)*\\)"
                                        ;"(define-c\\(class\\|proc\\|method\\|generic\\)\\(-fix\\)?\\s-+\\(\\(\\sw\\|\\s_\\)*\\)"
        ;; fixme: scheme-type/class/method-face
        1 'font-lock-important))        ;message-header-to-face

  )

(when nil
  (string-match "(define-c\\(?:class\\|proc\\|method\\|generic\\)\\(?:-fix\\)?\\s-+\\(\\(?:\\sw\\|\\s_\\)*\\)"
                ;;"(define-cproc\\s-+\\(\\(\\sw\\|\\s_\\)*\\)"
                " (define-cproc exif-ifd-get-name (id::<int>)"
                )
  (match-string 1 " (define-cproc exif-ifd-get-name (id::<int>)")
  (match-beginning 0)
  (match-end 0)
  )
(defvar scheme-type/class/method-face (make-face 'scheme-type/class/method-face))
(set-face-foreground scheme-type/class/method-face "Black")
(set-face-background scheme-type/class/method-face "VioletRed")
;(face-background ediff-current-diff-face-Ancestor) "")


(--
 '("(define-c\\(proc\\|method\\|generic\\)\\(-fix\\)?\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 2 font-lock-function-name-face))

'(when nil
  (length (nth 1 (aget font-lock-keywords-alist 'scheme-mode)))
					;(setcdr (aget font-lock-keywords-alist 'scheme-mode) nil)
  (aput 'font-lock-keywords-alist 'scheme-mode
	(nth 2 (aget font-lock-keywords-alist 'scheme-mode))
	)
  )



(provide 'scheme-font-lock)
