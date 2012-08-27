
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


(defun gitk ()
  "invoke `gitk'(1)"
  (interactive)
  (start-process "gitk" nil "gitk" "--all" "--max-count=100"))

(require 'mmc-python)
