(require 'sql)


;(setq sql-postgres-program "/usr/bin/psql")


;; fixme: why not run it just once?
(defun my-sql-hook ()
  ;; fixme: still necessary?
  (modify-syntax-entry ?_  "_" sql-mode-syntax-table)
  (set (make-local-variable 'outline-regexp)
       "^---*\\|select\\|create\\|begin"))

(defun sql-send-query (query)
  ""
  (with-temp-buffer
    (insert query)
    (sql-send-buffer)))

(defun sql-send-line ()
  ""
  (interactive)
  ;(mark-line)
  (sql-send-region (point-bol)
                   (point-eol)))


(define-key sql-mode-map (kbd "\C-cl") 'sql-send-line)

(define-key sql-mode-map ;(kbd "C-c C-l")
  ;[(control ?c) (control ?k)]
  (kbd "C-j")
  'sql-send-line)






;; fixme: only 1 globally?
(defun sql-buffer ()
  ""
  (inferior-process 'sql-mode))


(defun sql-send-string (query &optional this-buffer pop no-display)
  "Send a string to the SQL process."
  (interactive "r")
  (let ((buffer (or this-buffer (sql-buffer))))
    (if (or (processp buffer)
	    (buffer-live-p buffer))
	(save-excursion
	  (comint-send-string buffer query)
	  (unless (string-match "\n$" query)
	    (comint-send-string buffer "\n"))
	  (when (bufferp buffer)
	    (message "Sent string to buffer %s." (buffer-name buffer))
	    (if (or sql-pop-to-buffer-after-send-region pop)
		(pop-to-buffer buffer)
	      (unless no-display (display-buffer buffer)))))
      (message "No SQL process started."))))


;;; movement
(require 'mmc-comint)

(defun sql-backward-sexp (count)
  ""
  (interactive "p")
  (if (and (equal (comint-point-over-io? (point)) 'output)
	   ;; sorry this is broken
	   nil
           (featurep 'mdb))
      (mdb-previous-cell count)
    (backward-sexp count)))


(defun sql-forward-sexp (count)
  ""
  (interactive "p")
  (if (and
       (equal (comint-point-over-io? (point)) 'output)
       ;; broken
       nil)
      (mdb-next-cell count)
    (forward-sexp count)))


(define-key sql-interactive-mode-map [(control meta ?f)] 'sql-forward-sexp)
(define-key sql-interactive-mode-map [(control meta ?b)] 'sql-backward-sexp)


;;; Starting
(require 'rename-buffer)

;; (my-sql-postgres 't "linux1" "mmc" "maruska" "commits")


"Run psql by Postgres as an inferior process.

NEW -> 

If buffer `*SQL*' exists but no process is running, make a new process.
If buffer exists and a process is running, just switch to buffer
`*SQL*'.

Interpreter used comes from variable `sql-postgres-program'.  Login uses
the variables `sql-database' and `sql-server' as default, if set.
Additional command line parameters can be stored in the list
`sql-postgres-options'.

The buffer is put in sql-interactive-mode, giving commands for sending
input.  See `sql-interactive-mode'.

To specify a coding system for converting non-ASCII characters
in the input and output to the process, use \\[universal-coding-system-argument]
before \\[sql-postgres].  You can also specify this with \\[set-buffer-process-coding-system]
in the SQL buffer, after you start the process.
The default comes from `process-coding-system-alist' and
`default-process-coding-system'.  If your output lines end with ^M,
your might try undecided-dos as a coding system.  If this doesn't help,
Try to set `comint-output-filter-functions' like this:

\(setq comint-output-filter-functions (append comint-output-filter-functions
					     '(comint-strip-ctrl-m)))

\(Type \\[describe-mode] in the SQL buffer for a list of commands.)"





(defun my-sql-postgres (&optional new server user database buffer-name)
  "interactive -> use default values, or, w/ prefix  ask for confirmation "
  (interactive "p")
  ;; 
  (unless buffer-name (setq buffer-name  "*SQL*"))
  ;; try to reuse  buffer:
  (if (and (not new)
           (comint-check-proc buffer-name)) ; new -> don't rely on comint. 
      (pop-to-buffer buffer-name)
    ;; if we already are logged ??
    (let ((necessary-info (list 'database 'server))
          (job-name "SQL")
          tmp-buffer-name)


      ;; we have to use a trick.  make-comint  makes up a FIXED buffer name  *<name>*
      ;; so we rename ->   run   -> rename back
      (unwind-protect
          (progn
            (when (get-buffer buffer-name)
              ;; a little temporary hack:
              (setq tmp-buffer-name (generate-new-buffer-name (concat "*" job-name "*")))
              (rename-buffer-to buffer-name tmp-buffer-name))
            (if server (setq necessary-info (delete 'server necessary-info)))
            (if user (setq necessary-info (delete 'user necessary-info)))
            (if database (setq necessary-info (delete 'database necessary-info)))
            (apply 'sql-get-login necessary-info)
            (message "Login...")
            ;; username and password are ignored.  Mark Stosberg suggest to add
            ;; the database at the end.  Jason Beegan suggest using --pset and
            ;; pager=off instead of \\o|cat.  The later was the solution by
            ;; Gregor Zych.  Jason's suggestion is the default value for
            ;; sql-postgres-options.
            (let ((params sql-postgres-options))
              (if (not (string= "" sql-database))
                  (setq params (append params (list sql-database))))
              (if (not (string= "" sql-server))
		  ;; todo:  recognize port!
		  (if (string-match "^\\(.+\\):\\([0-9]+\\)$" sql-server)
		      (setq params (append (list "-h"
						 (match-string 1 sql-server)
						 "-p"
						 (match-string 2 sql-server)
						 ) params))
		    (setq params (append (list "-h" sql-server) params))))
              (set-buffer (apply 'make-comint job-name sql-postgres-program
                                 nil params))
              ;(set-buffer-process-coding-system 'emacs-mule 'emacs-mule)
	      (set-buffer-process-coding-system 'utf-8 'utf-8)
	      ;; no need to activate it!
	      (set-input-method "cyrillic-yawerty")
	      (inactivate-input-method)
	      )
            (if buffer-name (rename-buffer buffer-name))
            (setq sql-prompt-regexp "^.*> *")
            (setq sql-prompt-length 5)
            ;; This is a lousy hack to prevent psql from truncating it's output
            ;; and giving stupid warnings. If s.o. knows a way to prevent psql
            ;; from acting this way, then I would be very thankful to
            ;; incorporate this (Gregor Zych <zych@pool.informatik.rwth-aachen.de>)
            ;; (comint-send-string "*SQL*" "\\o \| cat\n")
            (setq sql-mode-font-lock-keywords sql-mode-postgres-font-lock-keywords)
            (setq sql-buffer (current-buffer))
            (sql-interactive-mode)
            (message "Login...done")
            (pop-to-buffer sql-buffer))
      
        (when tmp-buffer-name
          (rename-buffer-to tmp-buffer-name buffer-name))))))


(defun sql-get-prosrc ()
  ""
  "SELECT prosrc from pg_proc where proname='access_foto';"
  )


;;;;
'(
  (list "Hash Join" 0 'font-lock-builtin-face t)
  (list "Hash Join" 0 'font-lock-builtin-face t)
  (list "Seq Scan"  0 'font-lock-function-name-face t)
  (list "Index Scan" 0 'font-lock-function-name-face t)
  )


(defconst query-plan-font-lock-keywords
  `(
    ("Hash Join" . font-lock-builtin-face)
    ("Hash Cond" . font-lock-constant-face )

    ("Merge Join" . font-lock-type-face)
    ("Merge Cond" . font-lock-constant-face )
    
    ("\\(Seq Scan\\) on \\(\\w*\\) "
     (1 font-lock-function-name-face)
     (2 font-lock-variable-name-face))
                                        ;(:+ '("(with-cwd\\s-+\\(\\(\\sw\\|\\s_\\)*\\)" 1 font-lock-variable-name-face))
    ("\\(Index Scan\\) using \\(\\w*\\) on \\(\\w*\\)"
     (1 font-lock-function-name-face)
     (2 font-lock-def-face)
     (3 font-lock-variable-name-face))
    ("Sort" . font-lock-important)
    )
  "Expressions to highlight in Apache config buffers.")

(put 'query-plan-mode 'font-lock-defaults
     '(query-plan-font-lock-keywords t t
				     ((?_ . "w")
				      (?- . "w"))))



(get 'query-plan-mode 'font-lock-defaults)



(defun query-plan-mode ()
  "mainly fontification for the result of EXPLAIN command in postgreSQL"
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'query-plan-mode)
  (setq mode-name "Qplan")
                                        ;(use-local-map sql-mode-map)
  
                                        ;(kill-all-local-variables)
                                        ;(use-local-map apache-mode-map)
                                        ;(set-syntax-table apache-mode-syntax-table)
                                        ;(make-local-variable 'comment-start)
                                        ;(setq comment-start "# ")
                                        ;(make-local-variable 'comment-start-skip)
                                        ;(setq comment-start-skip "#\\W*")
                                        ;(make-local-variable 'comment-column)
                                        ;(setq comment-column 48)
                                        ;(setq mode-name "Apache")
                                        ;(setq major-mode 'apache-mode)
                                        ;(run-hooks 'apache-mode-hook)
  (set (make-local-variable  'font-lock-defaults)
                                        ;     query-plan-font-lock-keywords)
       '(query-plan-font-lock-keywords
         t t ((?_ . "w")
              (?. . "w"))))
  '(set (make-local-variable 'font-lock-defaults)
        query-plan-font-lock-keywords)
                                        ;(font-lock-set-defaults)
                                        ;(font-lock-fontify-buffer)
  )
  

(provide 'mmc-sql)
