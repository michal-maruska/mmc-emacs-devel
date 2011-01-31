(defvar sql-tempo-tags nil)
(put 'tempo-define-template 'lisp-indent-function 'defun)

(interactive 
(tempo-define-template "SELECT"
  '("SELECT " p n> "FROM " r n>  "WHERE " n ";")
  "SELECT"
  "Insert a select expression"
  'sql-tempo-tags)



					; select new_person();
					; update person set 
					; 	cognome='Sannino',
					; 	nome='Enrico',
					; 	via='via San Marino, 57',
					; 	citta='Torino',
					; 	cap='10137'
					; where numero=



;;; elisp
(tempo-define-template "defvar"
  '("defvar " p  n> "\"" p "\")")
  "defvar"
  "Insert a defvar expression"
  'elisp-tempo-tags)

(tempo-define-template "if"
  '("if " p n> r ")")
  "if"
  "Insert an if expression"
  'elisp-tempo-tags)

(tempo-define-template "cond"
  '("cond ((" p ") " r "))")
  "cond"
  "Insert a cond expression"
  'elisp-tempo-tags)

(tempo-define-template "interactive"	; name
  '("interactive " r ") ")		; the template
  "interactive"				; tag ... used for completion ?
  "Insert an interactive definition"	; doc
  'elisp-tempo-tags)			; taglist variable

; elisp-tempo-tags

;;; general

(defun tempo-space ()
  ""
  (interactive)
  (if (tempo-expand-if-complete)
      nil
    (insert " ")))

					; (define-key emacs-lisp-mode-map " " 'elisp-space)


					;(elisp-tempo)



(tempo-define-template "let"
  '("let (" p  n> "\)")
  "let"
  "Insert a let expression"
  'elisp-tempo-tags)

(tempo-define-template "lambda"
  '("lambda " p " (" p ")" n> "\"" p "\"" n> r ")")
  "lambda"
  "Insert a lambda expression"
  'elisp-tempo-tags)


(defun mdb-init-tempo ()
  "Set up sql mode to use tempo.el"
  (local-set-key "\C-c\C-f" 'tempo-forward-mark)
  (local-set-key "\C-c\C-b" 'tempo-backward-mark)
  ;;(local-set-key [M-C-tab] 'tempo-complete-tag)
  ;;(local-set-key " " 'elisp-space)
  ;;  (setq tempo-match-finder "\\b\\(\\w+\\)\\=")
  ;; in every buffer?
  (tempo-use-tag-list 'sql-tempo-tags))


(provide 'my-tempo-sql)
