;;; it also sets the hooks!
;;
(require 'xcscope)
(require 'mmc-c-styles)
;;
(setq cscope-database-regexps
      `(
        (,linux-sources-dirs-regexp
         ("~/git/linux/"
          ("-d" ))                      ;"-I/usr/local/include"
         )))



;;; patches:
(defun cscope-process-sentinel (process event)
  "Sentinel for when the cscope process dies."
  (let* ((buffer (process-buffer process)) window update-window
         (done t)
         (old-buffer (current-buffer))
         (old-buffer-window (get-buffer-window old-buffer)) )
;;;; here the patch:
    ;; Don't present the new buffer (file) inside minibuffer!
    (if (minibuffer-window-active-p old-buffer-window)
        (setq old-buffer-window
              (next-window old-buffer-window)))
;;;; enf-of patch:
    (with-current-buffer buffer
      (let (continue)
        (save-excursion
          (goto-char cscope-last-output-point)

          (if (or (and (setq window (get-buffer-window buffer))
                       (= (window-point window) (point-max)))
                  (= (point) (point-max)))
              (setq update-window t))
          (delete-process process)

          (when (= cscope-output-start (point))
            (insert " --- No matches were found ---\n"))

          (when (not cscope-start-directory)
            (setq cscope-start-directory default-directory))

          (setq continue
                (and cscope-search-list
                     (not (and cscope-first-match-point
                               cscope-stop-at-first-match-dir
                               (not cscope-stop-at-first-match-dir-meta)))))
          (when continue
            (setq continue (cscope-search-one-database)))
          (if continue
              (setq done nil)
            (insert "\nSearch complete.")
            (if cscope-display-times
                (let ( (times (current-time)) cscope-stop elapsed-time )
                  (setq cscope-stop (+ (* (car times) 65536.0)
                                       (cadr times)
                                       (* (cadr (cdr times)) 1.0E-6)))
                  (setq elapsed-time (- cscope-stop cscope-start-time))
                  (insert (format "  Search time = %.2f seconds."
                                  elapsed-time))
                  ))
            (insert "\n")
            (setq cscope-process nil)
            (if cscope-running-in-xemacs
                (setq modeline-process ": Search complete"))

            ;; save the directory of this search
            (let ((search-start-point (cscope-find-this-separator-start cscope-result-separator (1- (point)) t)))
              (put-text-property search-start-point (point) 'cscope-directory default-directory))

            (if cscope-start-directory
                (setq default-directory cscope-start-directory)))
          (set-buffer-modified-p nil))

        (if (and done cscope-first-match-point update-window)
            (if window
                (set-window-point window cscope-first-match-point)
              (goto-char cscope-first-match-point))
          )

        (when cscope-first-match-point
          (if cscope-display-cscope-buffer
              (if (and cscope-edit-single-match (not cscope-matched-multiple))
                  (cscope-show-entry-internal
                   (cscope-get-navigation-properties cscope-first-match-point (process-buffer process))
                   t))
            (cscope-select-entry-specified-window old-buffer-window)))

        ;; if the *cscope* buffer is too long, truncate it
        (with-current-buffer (process-buffer process)
          (when (and done
                     (> cscope-max-cscope-buffer-size 0)
                     (> (- (point-max) (point-min)) cscope-max-cscope-buffer-size))

            (save-excursion
              (goto-char (point-max))
              (let ((cut-at-point (cscope-find-this-separator-start
                                   cscope-result-separator
                                   (- (point-max) cscope-max-cscope-buffer-size)
                                   t)))
                (when cut-at-point
                  (delete-region (point-min) cut-at-point))))))

        (if (and done (eq old-buffer buffer) cscope-first-match-point)
            (cscope-help))))))

;; correct:
(add-hook 'gdb-mode-hook (function cscope:hook))
(add-hook 'gdb-mode-hook
          (lambda ()
            (make-local-variable 'cscope-initial-directory)))

;; cscope-command-args
;; http://cscope.sourceforge.net/large_projects.html
(set-default 'cscope-command-args (list "-R"))

;; find the map, and modify it:
(let
    ((my-cscope-map
     (lookup-key cscope-minor-mode-keymap
                                        ;cscope:map
                 (kbd "\C-cs"))))
  ;; "cscope map without the commong prefix")

  (define-key my-cscope-map "/" 'cscope-set-initial-directory)
  (global-set-key [(control ?#)] my-cscope-map)
  )


;; QT
; http://doc.trolltech.com/3.0/qkeyevent.html

;;; cscope

;; often the variable .... database is inherited from another buffer ... wrong !!
;; cscope-search-one-database
(setq cscope-display-cscope-buffer nil)
(setq cscope-do-not-update-database 't)


;; todo: autoload it!
(require 'etags)

;; `find-tag-tag' is the function which gets the default symbol from the buffer, under the `point'.
;; And I changed it to NOT prompt, unless I ask for it.
;; in 2012 I started to use Tags for .... Makefile targets (in Android)? or what?
(defun mmc-find-tag-tag (string prompt-p)
  "Get a tag/symbol from under the point.
If prompt-p, then ask confirmation. With defaulting and completion."
  (let* ((completion-ignore-case (if (memq tags-case-fold-search '(t nil))
                                     tags-case-fold-search
                                   case-fold-search))
         (default (funcall (or find-tag-default-function
                               (get major-mode 'find-tag-default-function)
                               'find-tag-default)))
         (spec
          (if (or (not default)
                  prompt-p)
              (completing-read
               (if default
                   (format "%s (default %s): "
                           (substring string 0 (string-match "[ :]+\\'" string))
                           default)
                 string)
                               (tags-lazy-completion-table)
                               nil nil nil nil default)
            "")))                       ; use default
    (if (equal spec "")
        (or default (user-error "There is no default tag"))
      spec)))


(defun mmc-find-tag(&optional prefix)
  "union of `find-tag' alternatives. decides upon major-mode"
  (interactive "P")
  (if (and (boundp 'cscope-minor-mode)
           cscope-minor-mode)
      (progn
        (ring-insert find-tag-marker-ring (point-marker))
        ;; (push-tag-mark)
        (setq cscope-display-cscope-buffer prefix)
        (call-interactively
         (if prefix
             'cscope-find-this-symbol
           'cscope-find-global-definition-no-prompting
           )))
    ;(call-interactively 'find-tag)
    (find-tag (mmc-find-tag-tag "Find tag: " prefix) nil )))

(eval-after-load "xref"
  '(substitute-key-definition 'xref-find-definitions 'mmc-find-tag global-map)
  )

;; find-tag
;; M-. runs the command xref-find-definitions
(defun cscope-reset ()
  "empty the minibuffer, if broken by cscope."
  (interactive)
  (with-current-buffer
      (get-buffer " *Minibuf-1*")
    (read-only-mode -1)
    (erase-buffer)))

(provide 'mmc-cscope)
