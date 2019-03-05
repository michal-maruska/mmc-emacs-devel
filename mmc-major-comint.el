;;; `switching' sql scheme lisp

;; comint

(defconst major-mode-comint-mapping
  ;; (major-mode variable function)
  '((sql-mode sql-buffer
              (my-sql-postgres))

    (gnuplot-mode gnuplot-buffer
                  (gnuplot-make-gnuplot-buffer)
                  )    ;gnuplot-kill-gnuplot-buffer

    (scheme-mode (and (functionp 'scheme-proc)	; (boundp 'scheme-proc)
                      (inferior-process-via-variable
                       'scheme-buffer
                       'inferior-scheme-mode))
                 (run-scheme (scheme-determine-program)))
    (sawfish-mode (inferior-process-via-variable
                   'sawfish-buffer
                   'inferior-sawfish-mode)
                                        ;(sawfish-proc)
                  (sawfish-console))



    (c-mode (inferior-process-via-variable
             'gud-comint-buffer
             'inferior-sawfish-mode)
                                        ;(sawfish-proc)
            ;(error "no gud")
            (sawfish-console))


    (python-mode (inferior-process-via-function 'py-shell)
                                        ;(sawfish-proc)
                  (py-shell))
                                        ;(lisp)
    )
  "mapping: mode -> form, which returns the associated commint buffer
and  start-form, which starts (a new) comint subprocess")


;; i could have a mapping  major-mode -> inferior-mode
(defun inferior-process-via-variable (local-variable inferior-mode)
  "Return the associated comint subprocess (in the INFERIOR-MODE). It is either the current buffer,
or stored in the LOCAL-VARIABLE."
  (let ((proc (get-buffer-process
               (if (eq major-mode inferior-mode)
                   (current-buffer)
                 (symbol-value local-variable)))))
    (or proc nil
        ;(error (format "No current process.  See variable `%s'" buffer-variable))
        )))


(defun inferior-process-via-function (function)
  "Return the associated comint subprocess (in the INFERIOR-MODE). It is either the current buffer,
or stored in the LOCAL-VARIABLE."
  (funcall function)
  (current-buffer))



;; todo  `throw'
(defun switch-to-inferior-process (mode)
  "go to the inferrior process buffer (for major MODE)."
  (interactive (list major-mode))
  (let ((buffer (inferior-process mode)))
    ;;
    (if (processp buffer)
        (setq buffer (process-buffer buffer)))
    ;;my temp hack
    (unless buffer
      (setq buffer "*inferior-lisp*"))
    (if buffer
        (unless (eq buffer (current-buffer))
          (if running-xemacs
              (switch-to-buffer-other-window buffer)
            (switch-to-buffer-other-window buffer 't))) ; do not record as visited ...
      (error "major mode not supported"))))

(defun get-info-manual-comint-mode()
  ""
  (when (eq major-mode 'Info-mode)
    (let ((file Info-current-subfile)
          )
      (cond
       ((string-match "gambit" file)
        '( (and (functionp 'scheme-proc) ; (boundp 'scheme-proc)
                (inferior-process-via-variable
                 'scheme-buffer
                 'inferior-scheme-mode))
           (run-scheme (scheme-determine-program))))))))

;;; common to sql, lisp, scheme ....
(defun inferior-process (mode) ; variable
  ""
  ;(interactive (list major-mode))
  (let ((info (or (aget major-mode-comint-mapping mode 't)
                  (get-info-manual-comint-mode))))
    (if info
        (let* ((get-buffer (nth 0 info))
              (start (nth 1 info))
              (buffer (eval get-buffer)))
          (if (or (and (processp buffer)
                       (buffer-live-p (process-buffer buffer)))
                  (and (bufferp buffer)
                       (buffer-live-p buffer)))
              ;(display-buffer buffer 't)
              buffer
            (eval start))))))

;; (proc (get-buffer-process
;;        (if (eq major-mode mode) ;inferior-lisp-mode
;;	   (current-buffer)
;;	 (symbol-value variable)))))
;; (or proc (error "No Lisp subprocess; see variable `inferior-lisp-buffer'"))))

(global-set-key [(control ?c) ?d] 'switch-to-inferior-process)
;(global-set-key [(control ?c) ?s] 'display-inferior-process)
; (global-set-key [(control ?c) ?s] nil);'display-inferior-process)

(provide 'mmc-major-comint)
