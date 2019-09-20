;; optional
(defun gitk (&rest prefix)
  "invoke `gitk'(1)"
  (interactive "P")
  (invoke-on-display nil
    (lambda ()

      (let ((buffer (current-buffer)))
        (if (equal prefix '(nil))
            (start-process "gitk" (get-buffer-create "*gitk*") "gitk-poset")
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

(provide 'mmc-git)
