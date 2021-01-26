;; Start the `mmc-emacs-devel' package:

(let ((package-load-list (list 'xcscope))
      )
  (package-initialize)
  (message "%s\n" load-path)
  )
(require 'mmc-scheme)
(require 'mmc-paredit)
(require 'mmc-lisp)
(require 'mmc-c-mode)
(require 'mmc-cscope)

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

(require 'mmc-display)
(require 'mmc-git)


(eval-after-load "python-mode"
  '(require 'mmc-python))


(eval-after-load "cc-mode" ;; java-mode
  '(require 'mmc-java))

(require 'mmc-android)
(add-to-list 'auto-mode-alist
             '("init.*\\.rc" . android-init-mode))

(eval-after-load "cmake-mode" ;; java-mode
  '(require 'mmc-cmake))
