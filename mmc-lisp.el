(require 'mmc-simple)

;;; Enhance by looking at source directories first:
;(eval-after-load "ffap.el")
;; notice, that this comes after other relevant items in the `ffap-alist' list
;; namely  *.elc? can find it faster!
(defun ffap-el (name)
  (or
   (ffap-locate-file name t find-function-source-path)
   (ffap-locate-file name t load-path)))
;;  this runs afterwards! so without el!
(defun ffap-el-mode (name)
  ;; If name == "foo.el" we will skip it, since ffap-el already
  ;; searched for it once.  (This assumes the default ffap-alist.)
  (let ((extensions '(".el")))
    (and (not (string-match "\\.el\\'" name))
         (or
          (ffap-locate-file name extensions find-function-source-path)
          (ffap-locate-file name extensions load-path)))))

;; Tempo
(load "tempo/tempo-elisp.el")

;; Where to search for source files:
;; ffap as well!
(setq find-function-source-path
      (mapcar 'expand-file-name
              '("~/repo/emacs/mmc-emacs/"
                "~/repo/emacs/config/"
                "~/repo/emacs/devel/")))

;;; lisp (s-expressions)
;(require 'ilisp)
(put 'font-lock-add-keywords 'lisp-indent-function 'defun)
(put 'font-lock-remove-keywords 'lisp-indent-function 'defun)
(put 'add-hook 'lisp-indent-function 1)


;; tempo
(defun list-argument (arg)
  ""
  (interactive "n")
  (up-list -1)
  (forward-char)
  (forward-sexp arg)
  (backward-sexp 1))




;;; `my-lisp-map':   M-C-x ...

(defvar my-lisp-map (make-sparse-keymap)
  "")

(let ((map my-lisp-map))
  (define-key map [(meta control ?x)]
                                        ;'eval-defun in emacs-lisp mode !!
    'lisp-eval-defun) ;you simply press it twice !

  (define-key map [(meta control ?x)] 'eval-defun) ; lisp-
  (define-key map [(meta control ?o)] 'wrap-function)

  (define-key map [(meta control ?i)] 'indent-defun)

  (define-key map [?d] 'down-list)
  (define-key map [(control ?d)] 'edebug-defun)
  (define-key map [?i] 'tempo-complete-tag)





  (define-key map [ (meta control ?u) ] 'up-list)
  (define-key map [ ?u ] 'up-list)




  (define-key map [ ?2 ] #'(lambda ()
                            (interactive)
                            (list-argument 2)))
  (define-key map [ ?1 ] #'(lambda ()
                            (interactive)
                            (list-argument 1)))

  (define-key map [ ?3 ] #'(lambda ()
                            (interactive)
                            (list-argument 3)))



  ;(lambda () (interactive)
  ;(insert-tem  tempo- "(interactive)")))


  ;; function
  ;; previous  beginning
  ;; next
  ;; commute ..
  ;;


  ;; and in my-scheme.el
  (define-key lisp-mode-map [(meta control ?x)] my-lisp-map)
  (define-key emacs-lisp-mode-map [(meta control ?x)] my-lisp-map)

  (define-key emacs-lisp-mode-map [(meta ?e)] 'up-list)

  (if (boundp 'scheme-mode-map)
      (define-key scheme-mode-map [(meta control ?x)] my-lisp-map))
  )



(eval-after-load
    "scheme"
  '(progn
     (define-key scheme-mode-map [ (control ?Y) ] 'backward-up-list)
     (define-key scheme-mode-map [ (control ?U) ] 'up-list)

     (define-key scheme-mode-map [ (control ?J) ] 'backward-up-list)
     (define-key scheme-mode-map [ (control ?K) ] 'up-list)
     (define-key scheme-mode-map [ (control ?L) ] 'down-list)
     ))



;;; other

;; (define-key shared-lisp-mode-map [(control ?d)] 'delete-char)

(if running-xemacs
    (defvar lisp-mode-shared-map lisp-mode-map ""))

(define-key
  lisp-mode-shared-map
  ;;shared-lisp-mode-map
  [backspace]
  'backward-delete-char-untabify)

; shared-lisp-mode-map
(define-key lisp-mode-shared-map [(control ?x) ?x ?b] 'byte-compile-this-file)
(define-key lisp-mode-shared-map [f2] 'byte-compile-file)


(defvar sexp-keymap (make-sparse-keymap) "")
(let ((map sexp-keymap)
      )
  (global-set-key [(control ?x) ?c] map)
  (define-key map [(control ?i)] 'indent-sexp))


(require 'mmc-keys)
(switch-keys lisp-mode-shared-map [(control ?m)] [(control ?j)])
;; (define-key shared-lisp-mode-map [(control ?m)] (lookup-key global-map [(control ?j)]))
;; (define-key shared-lisp-mode-map [(control ?j)] 'newline)




;; Note method:
; (setq lisp-imenu-generic-expression
;       '(
;       (nil
;        "^\\s-*(def\\(un\\|subst\\|macro\\|advice\\|method\\|ine-skeleton\\)\\s-+\\([-A-Za-z0-9+*|:/]+\\)" 2)
;       ("Variables"
;        "^\\s-*(def\\(var\\|const\\|custom\\)\\s-+\\([-A-Za-z0-9+*|:/]+\\)" 2)
;       ("Types"
;        "^\\s-*(def\\(group\\|type\\|struct\\|class\\|ine-condition\\)\\s-+\\([-A-Za-z0-9+*|:/]+\\)"
;        2)))

(when nil
  (let ((count 0))
  (mapatoms
   (lambda (symbol)
     (when (and (functionp symbol)
                (not (or (compiled-function-p (symbol-function symbol))
                         (subrp (symbol-function symbol)))))
       (setq count (1+ count))
       (print symbol)))
   obarray)
  (message "count: %d" count)))
;; (subrp 'read)



;;; `Font-lock' ??
(font-lock-add-keywords
 'emacs-lisp-mode
 ;'(("fixme" . font-lock-keyword-face)))
 '(("\\<\\(FIXME\\):" 1 font-lock-warning-face prepend)) ; even in comments FIXME:
 )



(when nil
  (setq lisp-font-lock-keywords-2
      (append lisp-font-lock-keywords-2
              (list
               ;; highlight warnings
               (if sawfish-warning-keyword-list
                   (list (concat "\\<"
                                 `,(regexp-opt sawfish-warning-keyword-list)
                                 "\\>")
                         '(0 font-lock-warning-face prepend)))))))

(defun insert-at (point char)
  ""
  (save-excursion
    (goto-char point)
    (insert char)))

;; (define-skeleton wrap-function
;;   ""
;;   "(" _ r ")")


(defun wrap-function (start end)
  ""
  (interactive "r")
                                        ;(push-mark)
                                        ;(undo-group...)
  (let ((start-marker (make-marker))
        (end-marker (make-marker)))
    (set-marker start-marker start)
    (set-marker end-marker end)
    (insert-at end-marker ")")
    (insert-at start-marker "(")
    (goto-char start-marker)
    (forward-char 1) (insert " ") (backward-char 1)))

;; commutate functions
;; (a (b ...)) -> (b (a))


(provide 'mmc-lisp)

;(set-variable (quote next-line-add-newlines) 't)
