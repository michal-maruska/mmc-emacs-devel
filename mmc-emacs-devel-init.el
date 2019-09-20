;; Start the `mmc-emacs-devel' package:
(require 'mmc-scheme)
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


(when (locate-library "paredit")
  (autoload 'enable-paredit-mode "paredit"
    "Turn on pseudo-structural editing of Lisp code."
    t)
  ;; is this defined already?
  (add-hook 'scheme-mode-hook 'enable-paredit-mode)
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  )

(eval-after-load "cmake-mode" ;; java-mode
  '(require 'mmc-cmake))
