;; http://ruska.dyndns.org/comp/activity/python/ffap.py
;; http://ruska.dyndns.org/comp/activity/emacs/my-python.el

(if (featurep 'python-mode)
    (require 'python-mode))

(require 'mmc-simple)

(eval-after-load "python-mode"
  '(progn
     (define-key py-mode-map [(backspace)]    'py-electric-backspace) ;"\C-h"
     (define-key py-mode-map [(control meta ?u)]    'py-goto-block-up)
     (define-key py-mode-map [(control meta ?f)]    'py-forward-block)
     (define-key py-mode-map [(control meta ?b)]    'py-backward-block)
     ;(define-key py-mode-map [(meta ?f)]    nil)
     ;;(define-key py-mode-map "\e\C-a"    'py-beginning-of-def-or-class)
     ))


;; make use of standard functions/commands.
;; provide the missing building-block:
;; fixme: (still) needed?  is this re-defining some function?
;; so see below!
(defun python-mode-beginning-of-defun-function (ignore-arg)
   ""
   (py-beginning-of-def-or-class 'either))

(defun my-python-mode-hook ()
  ;; make-variable-buffer-local
  (set (make-local-variable 'beginning-of-defun-function)
       'py-backward-def-or-class
                                        ;python-mode-beginning-of-defun-function
       )
  (eldoc-mode -1)
  (set (make-local-variable 'outline-regexp)
        " *\\(def\\|class\\) "))

;; (setq python-mode-hook ;; py-indent-tabs-mode
(add-hook 'python-mode-hook 'my-python-mode-hook)

(defun py-next-block ()
  "go to the next block.  Cf. `forward-sexp' for lisp-mode"
  (interactive)
  (py-mark-block) ;;  nil 't)
  (back-to-indentation))




;;; ffap
(when nil
  ;; 2013: disabling, as the script is not there!

  (defvar python-ffap-script (expand-file-name "~/activity/python/ffap.py")
    "this program is run w/ 1 argument, to locate the python module...file.
run in the cwd of the edited file.")

  (defun ffap-python (name)
    (let ((path (shell-command-to-string-no-nl
                 (concat
                  (shell-quote-argument python-ffap-script)
                  " "
                  (shell-quote-argument name)))))
      path))

  (aput 'ffap-alist 'python-mode 'ffap-python)
  )



;;; Alternative:
(defun python-ffap (string)
  (interactive)
  ;;
  (let ((python-syntax-table (syntax-table))
        )
    (unwind-protect
        (progn
          (modify-syntax-entry ?: "_" python-syntax-table)
          ;; (char-syntax ?:)
          ;; (set-syntax "::" symbol)
          (let* ((module-name string)
                 (relative (add-suffix-optionally
                            (translate-module-to-filename module-name "\\.")
                            ".py"))
                 (path (find-subpath-in-paths
                        relative
                        ;; fixme: todo:  use bin/python to find it!
                        (list "."
                              "/usr/lib/python2.7/dist-packages/"))))
            path))
      (modify-syntax-entry ?:  "." python-syntax-table))))

;; ffap-alist
(add-to-list 'ffap-alist '(python-mode . python-ffap))


(provide 'mmc-python)
