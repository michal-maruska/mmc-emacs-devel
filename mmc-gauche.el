


(defun gauche-where-is (symbol)
  "Interract gosh subprocess about the source file for ..."
  (interactive
   (list (thing-at-point 'symbol)))
  (scheme-send-string (format "(apropos '%s)\n" symbol)))


(defun gauche-find-definition (symbol)
  ""
  (interactive
   (list (thing-at-point 'symbol)))
  ;; file/line-no
  )

(require 'mmc-string)

(defconst gauche-load-path () "")

(defun gauche-query-load-path ()
  ""
  (with-temp-buffer
    (call-process "gosh"
		  nil t t
		  "-b"
		  "-e"
		  "(progn (write *load-path*)(newline) (exit))")
    (goto-char (point-min))
    (read (current-buffer))))

(defun ffap-gauche-mode (name)
  "Given string/name of sawfish/rep module: XXX.YYY.ZZZ.module,
find and return its path in the filesystem"
  (let ((relative (add-suffix-optionally
		   (translate-module-to-filename name "\\.") ".scm"))
        ;; /usr/bin/gosh   -e '(begin (format #t  "~a\n\n" *load-path*) (sys-exit 0))'
	path found)

    (unless gauche-load-path
      (setq gauche-load-path
	    (gauche-query-load-path)))

    (setq found
          (list-search-positive
           (lambda (item)
             (file-if-exists
              (file-name-in-directory item relative)))
           gauche-load-path))
    found))



(provide 'mmc-gauche)
