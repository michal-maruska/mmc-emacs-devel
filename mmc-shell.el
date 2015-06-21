
(add-to-list 'ffap-alist
	     '(sh-mode . zsh-find-function))

(defun zsh-find-function (function)
  "Ask Zsh(1) in a subprocess, for the location of named function
 (its source code)"
  (let ((output (shell-command-to-string
		 (concat "zsh  -c 'echo $^fpath/"
			 function"(N)'"))))
    (if (> (length output) 2)
	(substring output 0 (- (length output) 1)))))


(provide 'mmc-shell)
