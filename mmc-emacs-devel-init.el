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

;; optional
(defun gitk (&rest prefix)
  "invoke `gitk'(1)"
  (interactive "P")
  (invoke-on-display nil
    (lambda ()

      (let ((buffer (current-buffer)))
        (if (equal prefix '(nil))
            (start-process "gitk" nil "gitk-poset")
          ;; let the user edit the cmd line:
          ;; fixme: bury that Async Command buffer!
          (apply 'start-process "gitk" nil
                 (split-string
                  (read-shell-command "Edit command: "
                                      (concat
                                       "gitk --all --max-count=200 "
                                       (file-name-nondirectory
                                        (or (buffer-file-name buffer)
                                            default-directory
                                        ;(dired-current-directory)
                                            ))))
                  " ")))))))

;;;(magit-get-top-dir (file-name-directory (buffer-file-name)))
;;(bury-buffer "*Async Shell Command*")
(global-set-key [(alt j)] 'gitk)


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
