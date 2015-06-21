;; ffap-alist


(require 'mmc-simple)
;; horror!
;; I override the ffap.el's
(defun ffap-tex (name)
  (ffap-tex-init)
  (let ((path (shell-command-to-string-no-nl (format "/usr/bin/kpsewhich %s" (shell-quote-argument name)))))
    (if (string= path "") nil
      path)))


(eval-after-load "ffap"
  '(aput 'ffap-alist 'plain-tex-mode 'ffap-tex) ;-mode
  )

(provide 'mmc-tex)
