;;; `Magit'

;; sometimes I neede the .el file
(when (require 'magit-autoloads nil 'no-error)
  ;; why?
  (require 'with-editor)
  (require 'git-commit)
  )

(when (locate-library "magit")
  (require 'magit)
  ;; /etc/emacs/site-start.d/50magit.el
  (autoload 'magit-status "magit" nil t)

  ;; obsolete?
  ;; (setq magit-rigid-key-bindings t)

  (global-set-key [(alt ?g)] 'magit-status)

  ;; installed manually:
  (define-key magit-mode-map
	      (kbd "o") 'magit-section-up
	      ;; 'magit-goto-parent-section
	      )

  (define-key magit-mode-map
	      (kbd "M-i") 'magit-section-show-children
	      ;; 'magit-goto-parent-section
	      )
  (define-key magit-mode-map
	      (kbd "S-RET") 'magit-diff-visit-worktree-file
	      ;; 'magit-goto-parent-section
	      )
  )



