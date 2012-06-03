


(defun gauche-where-is (symbol)
  (interactive
   (list (thing-at-point 'symbol)))
  (scheme-send-string (format "(apropos '%s)\n" symbol)))


(defun gauche-find-definition (symbol)
  ""
  (interactive
   (list (thing-at-point 'symbol)))
  ;; file/line-no
  )



(defun ffap-gauche-mode (name)
  "Given string/name of sawfish/rep module: XXX.YYY.ZZZ.module,
find and return its path in the filesystem"
  (let ((relative (add-suffix-optionally
		   (translate-module-to-filename name ".") ".scm"))
        ;; /usr/bin/gosh   -e '(begin (format #t  "~a\n\n" *load-path*) (sys-exit 0))'
        (gauche-load-path '(
			    ;; todo: eval  gauche -e '*load-path*'
			    "/usr/share/gauche/0.8.13/lib"
                            "."
                            "/x/activity/scheme/gauche/bdb"
                            ;"/x/activity/scheme/gauche/pg"
                            ; /x/activity/scheme/gauche
                            "~/gauche/"
                            "/usr/share/gauche/site/lib"
                            "/usr/lib/kahua"
                            ))
        path found)
    (setq found
          (list-search-positive
           (lambda (item)
             (file-if-exists
              (file-name-in-directory item relative)))
           gauche-load-path))
    found))



(provide 'mmc-gauche)
