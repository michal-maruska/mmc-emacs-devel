
;; Start the `mmc-emacs-devel' package:
(require 'mmc-scheme)
(require 'mmc-lisp)
(require 'mmc-c-mode)
(require 'mmc-tex)

(require 'mmc-shell)

(require 'mmc-comint)
(require 'mmc-major-comint)

;; ??
(require 'mmc-doc)
(eval-after-load "gud"
  '(require 'mmc-gud))

;; After?
(require 'mmc-sql)

(autoload 'kconfig-mode "kconfig")
(add-to-list 'auto-mode-alist '("Kconfig" . kconfig-mode))


;; optional
(defun gitk (&rest prefix)
  "invoke `gitk'(1)"
  (interactive "P")
  (if (equal prefix '(nil))
      (start-process "gitk" nil "gitk" "--all" "--max-count=200")
    ;; let the user edit the cmd line:
    (shell-command (concat
		    (read-shell-command "Edit command: "
				       "gitk --all --max-count=200")
		    "&"))))

(require 'mmc-python)
