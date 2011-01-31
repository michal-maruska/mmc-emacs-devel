
;; Start the `mmc-emacs-devel' package:
(require 'mmc-scheme)
(require 'mmc-lisp)
(require 'mmc-c-mode)
(require 'mmc-tex)

(require 'mmc-comint)
(require 'mmc-major-comint)

;; ??
(require 'mmc-doc)
(eval-after-load "gud" 
  '(require 'mmc-gud))

;; After?
(require 'mmc-sql)
