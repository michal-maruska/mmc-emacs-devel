(require 'tempo)
(defvar elisp-tempo-tags nil)

(tempo-define-template
 "defun"
 '("defun " p " (" p ")" n> "\"" p "\"" n> r ")")
 "defun"
 "Insert a defun expression"
 'elisp-tempo-tags)

(tempo-define-template
 "defvar"
 '("defvar " p  n> "\"" p "\")")
 "defvar"
 "Insert a defvar expression"
 'elisp-tempo-tags)

(tempo-define-template
 "if"
 '("if " p n> r ")")
 "if"
 "Insert an if expression"
 'elisp-tempo-tags)

(tempo-define-template
 "cond"
 '("cond ((" p ") " r "))")
 "cond"
 "Insert a cond expression"
 'elisp-tempo-tags)

(tempo-define-template
 ;;  "mapc\(ar\)?"
 "mapcar"
 '("mapcar" n> "(lambda (item)" n> p ")" n> ")")
 ;"mapc\(ar\)?"
 "mapcar"
 "Insert a lamda expression"
 'elisp-tempo-tags)

(tempo-define-template
 ;;  "mapc\(ar\)?"
 "mapc"
 '("mapc" n> "(lambda (item)" n> p ")" n> ")")
 ;"mapc\(ar\)?"
 "mapc"
 "Insert a lamda expression"
 'elisp-tempo-tags)

(tempo-define-template
 "let"
 '( "let (" p  n> "\)"  n> p "\)" )
 "let"
 "Insert a let expression"
 'elisp-tempo-tags)

(tempo-define-template
 "lambda"
 '("lambda " p " (" p ")" n> "\"" p "\"" n> r ")")
 "lambda"
 "Insert a lambda expression"
 'elisp-tempo-tags)


(tempo-define-template
 "let"
 '("let (" p  n> "\)")
 "let"
 "Insert a let expression"
 'elisp-tempo-tags)

(tempo-define-template
 "lambda"
 '("lambda " p " (" p ")" n> "\"" p "\"" n> r ")")
 "lambda"
 "Insert a lambda expression"
 'elisp-tempo-tags)
