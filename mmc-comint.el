
(require 'mmc-major-comint)


;; una volta ho dovuto:
;; '(defun comint-simple-send (proc string)
;;   "Default function for sending to PROC input STRING.
;; This just sends STRING plus a newline. To override this,
;; set the hook `comint-input-sender'."
;;   (comint-send-string proc string)
;;-   (comint-send-string proc "
"))       "




(defun comint-point-over-io? (point)
  "is the poing over input or output ?"
  (interactive "d")
  (if (eq (get-char-property point 'field) 'input)
      'input
    'output))




'(defun comint-kill-output ()
  ""
  (interactive)
  (kill-region (point)
	       (comint-next-prompt 1)))



;;; old
(require 'comint)
(custom-set-variables '(comint-completion-fignore '("~")))

;; (require 'sql)
;; (require 'psql)

(define-key comint-mode-map [(control ?c) (control ?b)] 'comint-goto-process-mark)
(define-key comint-mode-map [(control ?c) (control ?k)] 'comint-kill-output)


;; slime
(define-key comint-mode-map [(control ?c) (control ?p)] 'comint-previous-prompt)




;; this is wrong in the comint.el !!!
(defun comint-simple-send (proc string)
  "Default function for sending to PROC input STRING.
This just sends STRING plus a newline. To override this,
set the hook `comint-input-sender'."
  (comint-send-string proc string)
  (comint-send-string proc "
"))




;; Gentoo installed slime: /usr/share/emacs/site-lisp/70slime-gentoo.el

;(setq inferior-lisp-mode-hook ())

;; How to disable a keymap?

(provide 'mmc-comint)