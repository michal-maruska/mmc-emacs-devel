;; helm: Emacs incremental completion and selection narrowing framework

;; Bear is a tool that generates a compilation database for clang tooling.
;; compile_commands.json

;; M-x emacs-build-configuration --with-modules --with-json
;; -without-modules       don't compile with dynamic modules support


;; In GNU Emacs 29.4 (build 2, x86_64-pc-linux-gnu, X toolkit, cairo version 1.18.0, Xaw3d scroll bars) of 2024-06-30, modified by
;;  Debian built on sbuild
;; Windowing system distributor 'The X.Org Foundation', version 11.0.12101011
;; System Description: Debian GNU/Linux trixie/sid

;; Configured using:
;;  'configure --build x86_64-linux-gnu --prefix=/usr --sharedstatedir=/var/lib --libexecdir=/usr/libexec --localstatedir=/var/lib
;;  --infodir=/usr/share/info --mandir=/usr/share/man --with-libsystemd --with-pop=yes
;;  --enable-locallisppath=/etc/emacs:/usr/local/share/emacs/29.4/site-lisp:/usr/local/share/emacs/site-lisp:/usr/share/emacs/29.4/site-lisp:/usr/share/emacs/site-lisp
;;  --with-sound=alsa --without-gconf --with-mailutils --with-native-compilation --build x86_64-linux-gnu --prefix=/usr
;;  --sharedstatedir=/var/lib --libexecdir=/usr/libexec --localstatedir=/var/lib --infodir=/usr/share/info --mandir=/usr/share/man
;;  --with-libsystemd --with-pop=yes
;;  --enable-locallisppath=/etc/emacs:/usr/local/share/emacs/29.4/site-lisp:/usr/local/share/emacs/site-lisp:/usr/share/emacs/29.4/site-lisp:/usr/share/emacs/site-lisp
;;  --with-sound=alsa --without-gconf --with-mailutils --with-native-compilation --with-x=yes --with-x-toolkit=lucid
;;  --with-toolkit-scroll-bars --without-gsettings 'CFLAGS=-g -O2 -Werror=implicit-function-declaration
;;  -ffile-prefix-map=/build/reproducible-path/emacs-29.4+1=. -fstack-protector-strong -fstack-clash-protection -Wformat
;;  -Werror=format-security -fcf-protection -Wall' 'CPPFLAGS=-Wdate-time -D_FORTIFY_SOURCE=2' LDFLAGS=-Wl,-z,relro'

(when nil
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  (package-initialize)

  (setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs helm-lsp
                                             projectile hydra flycheck company avy which-key helm-xref dap-mode))

  ;; which-key https://github.com/justbur/emacs-which-key ... show bindings under prefix
  ;; company ... com-lete Anything
  ;; helm ?  ido -like.
  ;; dap ... Debug Adapter Protocol client for Emacs.

  ;; treemacs   A powerful and flexible file tree project explorer.  -- side
  ;; macros?

  ;; hydra

  (when (cl-find-if-not #'package-installed-p package-selected-packages)
    (package-refresh-contents)
    (mapc #'package-install package-selected-packages))

  ;; sample `helm' configuration use https://github.com/emacs-helm/helm/ for details
  (helm-mode)
  (require 'helm-xref)
  (define-key global-map [remap find-file] #'helm-find-files)
  (define-key global-map [remap execute-extended-command] #'helm-M-x)
  (define-key global-map [remap switch-to-buffer] #'helm-mini)
)

(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)
(add-hook 'rust-ts-mode 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))



(add-hook 'after-init-hook 'global-company-mode)

;; faces too small:
;; lsp-face-highlight-read lsp-face-highlight-textual lsp-face-highlight-write

;; in-project

(defun lsp-reset-faces ()
  ""
  (interactive)
  ;; sometimes resets
  (copy-face 'underline 'lsp-face-highlight-textual)

  ;; local variables?
  ;; fixme: resets too
  (copy-face 'underline 'lsp-face-highlight-read)
  ;; (face-attribute 'lsp-face-highlight-textual :inherit)

  ;; (customize-face )

  ;; variables written to:
  (copy-face 'underline 'lsp-face-highlight-write))

(custom-set-faces
                                        ;'(diff-added ((t (:foreground "green"))))
 '(lsp-face-highlight-write ((t (:inherit  underline))))
 '(lsp-face-highlight-textual ((t (:inherit  underline))))
 '(lsp-face-highlight-read  ((t (:inherit  underline)))))

(lsp-reset-faces)
(require 'mmc-cscope)
;; (load "~/repo/emacs/devel/mmc-cscope.el")


;; Go
(use-package go-mode
  :ensure t
  :mode "\\.go\\'"
  :preface
  (defun vd/go-lsp-start()
    (define-key go-ts-mode-map
                ["RET"] 'newline-and-indent)
    (define-key go-ts-mode-map
                ["M-RET"] 'newline)
    (add-hook 'before-save-hook #'lsp-format-buffer t t)
    (add-hook 'before-save-hook #'lsp-organize-imports t t)
    (lsp-deferred)
    )
  :hook
  (go-ts-mode . vd/go-lsp-start)
  :custom
  (go-ts-mode-indent-offset 4)
  :config
  (add-to-list 'exec-path "~/.local/bin")
  (setq lsp-go-analyses '(
                          (nilness . t)
                          (shadow . t)
                          (unusedwrite . t)
                          (fieldalignment . t)
                          )
        lsp-go-codelenses '(
                            (test . t)
                            (tidy . t)
                            (upgrade_dependency . t)
                            (vendor . t)
                            (run_govulncheck . t)
                            )
        )
  )

(use-package go-tag
  :ensure t
)

(use-package godoctor
  :ensure t
)

(provide 'mmc-lsp-setup)
