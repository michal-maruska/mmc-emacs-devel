;;; `paredit:'

(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code."
  t)

(when (locate-library "paredit")

    (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
    (add-hook 'scheme-mode-hook 'enable-paredit-mode)
    )

;; mmc: sorry Ria!
(eval-after-load "paredit"
  '(progn
     ;; is this defined already?

     (define-key paredit-mode-map (kbd "C-S-b") 'paredit-add-to-previous-list)
     (define-key paredit-mode-map (kbd "C-S-f") 'paredit-add-to-next-list)
     ;; back?
     (define-key paredit-mode-map (kbd ")") 'paredit-close-round)


     (define-key paredit-mode-map
       (kbd "\C-c ;")
       ;;[(control \#c) \;]
       'paredit-semicolon)

     (define-key paredit-mode-map ";" 'self-insert-command)
     (define-key paredit-mode-map ")" 'self-insert-command)

     ;; paredit
     (paredit-define-keys)

     '(setcar
      (assoc
       "C-M-f"
       paredit-commands)
      "M-f")

     '(setcar
      (assoc
       "C-M-b"
       paredit-commands)
      "M-b")
     ))

(provide 'mmc-paredit)
