(require 'tempo)
(defvar sql-tempo-tags nil)

(tempo-define-template "SELECT"
		       '("SELECT " p n> "FROM " r n>  "WHERE " n ";")
		       "SELECT"
		       "Insert a select expression"
		       'sql-tempo-tags)





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
