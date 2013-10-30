;; (java-find-class/package "com.android.internal.util.StateMachine")


(defun find-line-by-string (string filename)
  ""
  (with-current-buffer (find-file-noselect filename 'nowarn 'rawfile)
    ;; (set-buffer buffer)
    (goto-char (point-min))
    ;; at end of line
    (if (search-forward relative)
	;; buffer-substring-no-properties
	(erase-text-properties (line-string))
      nil)))

(defun java-find-class/package (symbol)
  "ffap implementation to use ...."
  (save-excursion
    (let ((relative (add-suffix-optionally
		     (translate-module-to-filename symbol "\\.") ".java")))
      (concat "~/next/"
	      (find-line-by-string relative "~/next/cscope.files.java")))))

(defun my-java-mode-hook ()
  ""
  ;; how to hide/show ??
  (set (make-local-variable 'outline-regexp)
	" *(public|private|void)")
  (setq c-basic-offset 4))

;; java-mode-hook
(add-hook 'java-mode-hook 'my-java-mode-hook)


;; ffap-alist
(add-to-list 'ffap-alist
	     '(java-mode . java-find-class/package))


(provide 'mmc-java)
