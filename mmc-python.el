;; http://ruska.dyndns.org/comp/activity/python/ffap.py
;; http://ruska.dyndns.org/comp/activity/emacs/my-python.el

(require 'python-mode)
(eval-after-load "python-mode"
  '(progn
     (define-key py-mode-map [(backspace)]    'py-electric-backspace) ;"\C-h"
     (define-key py-mode-map [(control meta ?u)]    'py-goto-block-up)
     (define-key py-mode-map [(control meta ?f)]    'py-next-block)
     ;(define-key py-mode-map [(meta ?f)]    nil)
                                        ;(define-key py-mode-map "\e\C-a"    'py-beginning-of-def-or-class)
     ))


;; make use of standard functions/commands.
;; provide the missing building-block:
(defun python-mode-beginning-of-defun-function (ignore-arg)
  ""
  (py-beginning-of-def-or-class))


(add-hook 'python-mode-hook
  (lambda ()
    (make-local-variable ;; make-variable-buffer-local
     'beginning-of-defun-function)
    (setq beginning-of-defun-function
	  'python-mode-beginning-of-defun-function)))

(defun py-next-block ()
  "go to the next block.  Cf. `forward-sexp' for lisp-mode"
  (interactive)
  (py-mark-block nil 't)
  (back-to-indentation))

;; (setq python-mode-hook ())
(add-hook 'python-mode-hook
          (lambda ()
            (set (make-variable-buffer-local 'beginning-of-defun-function)
                 'py-beginning-of-def-or-class)
            (setq outline-regexp "def\\|class ")
	    ;; (setq outline-regexp "^def ")
	    ))


(defvar python-ffap-script (expand-file-name "~/activity/python/ffap.py")
  "this program is run w/ 1 argument, to locate the python module...file. run in the cwd of the edited file.")

(require 'mmc-simple)

(defun ffap-python (name)
  (let ((path (shell-command-to-string-no-nl
               (concat
                (shell-quote-argument python-ffap-script)
                " "
                (shell-quote-argument name)))))
    path))

(aput 'ffap-alist 'python-mode 'ffap-python)

(provide 'mmc-python)
