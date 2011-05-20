;; [12 lug 03]  i start to share it w/  sawfish !!!



;;; I want a quick access to html manuals:
(defvar htmldoc-alist '() "")

(defconst htmldoc-file "~/.bookmarks.sexp" "")



(defun update-doc-bookmarks ()
  ""
  (with-temp-buffer
    (insert-file-contents htmldoc-file)
    (setq htmldoc-alist (read (current-buffer)))))


(defun html-documentation (book)
  ""
  (interactive
   (progn
     (update-doc-bookmarks)
     (list (completing-read "book: " htmldoc-alist))))
  (xterm nil (format "elinks '%s'"
		     (car (aget htmldoc-alist book)))
	 (format "%s manual (exterm links)" book)))



(defun html-documentation-of-file (arg)
  ""
  (interactive "P")
  (if arg
      (find-file-other-window htmldoc-file) ;find docs on htmldoc-alist
    (call-interactively 'html-documentation)))


(global-set-key [(alt ?y)] 'html-documentation-of-file)

(provide 'mmc-doc)
