;;; Customization of C-mode derived modes. Apart from the style.

(require 'mmc-simple) ;; file-under-p find-line-by-string

(require 'mmc-font-lock)
(require 'cc-mode)
(require 'mmc-syntax)

;; Anything related to style (formatting) should go here:
(require 'mmc-c-styles)

(require 'ffap)

;; patches:  -p !
(defun my-turn-on-auto-newline ()
  ;; this is part of the electric-keys functionality: I want it.
  ;; paren-space-brace for example!
  ;; after brace, comma, ; :
  ;; /la in modeline
  (c-toggle-auto-newline 1))

(add-hook 'c-mode-common-hook 'my-turn-on-auto-newline)

;;; outline:
(add-hook 'c-mode-hook
  (lambda ()
    (define-key c-mode-base-map (kbd "C-m") 'c-context-line-break)))

;;; font-lock
(font-lock-add-keywords
  'c-mode
  '(("set_frame_shapes" 0 font-lock-builtin-face))
  '(("mmc:" 0 font-lock-builtin-face))
  )

(when nil
  (aget font-lock-keywords-alist 'c-mode)

  (setq font-lock-keywords-alist
        (aput 'font-lock-keywords-alist 'c-mode '()))
  (setq font-lock-keywords-alist
        (cdr font-lock-keywords-alist))
  )

;;; ffap:

;; see mmc-c-mode.el for cscope-based solution: todo: cron -> reindex!
(defun decide-for-c-include-path (filename)
  "Extend 'ffap-c-path' paths list for a C-mode,
based on filename."
  (cond
   ((string-match "next/kernel/" filename)
    (add-to-list-rest 'ffap-c-path
                      "~/next/kernel/include"))

   ((string-match "spark/linux-2.6.28.10/" filename)
    (add-to-list-rest 'ffap-c-path
                      "~/perforce/spark/linux-2.6.28.10/include"))

   ((string-match "italia/" filename)
    ;; fixme: only for italia. see ...
    ;; fixme: todo: shared variable ....
    (make-local-variable 'ffap-c-path)
    (add-to-list-rest 'ffap-c-path
                      "~/italia/frameworks/native/include/" ;utils/Log.h
                      "~/italia/system/core/include/"
                                        ;"~/perforce/spark/linux-2.6.28.10/include"
                      ))

   ((string-match "gallo/" filename)
    ;; fixme: only for italia. see ...
    ;; fixme: todo: shared variable ....
    (make-local-variable 'ffap-c-path)
    (add-to-list-rest 'ffap-c-path
                      "~/gallo/frameworks/native/include/" ;utils/Log.h
                      "~/gallo/system/core/include/"
                                        ;"~/perforce/spark/linux-2.6.28.10/include"
                      "~/gallo/hardware/libhardware/include"
                      ))

   ((or (string-match "nav4/" filename)
        (string-match "next/" filename))
    (make-local-variable 'ffap-c-path)
    (add-to-list-rest
     'ffap-c-path
     "~/nav4/frameworks/native/include/" ;utils/Log.h
     "~/nav4/system/core/include/"
     "~/nav4/frameworks/base/include/"))

   ((string-match "/NavKit/" filename)
    ;; fixme: only for italia. see ...
    ;; fixme: todo: shared variable ....
    ;; relative to it!
    (let ((navkit-root (if (string-match "^\\(.*/NavKit/\\)" filename)
                           (match-string 1 filename)
                         nil)))
      (make-local-variable 'ffap-c-path)
      (add-to-list-rest 'ffap-c-path
                        (compose-path navkit-root)
                        (compose-path navkit-root "Framework/Common/Logging/Interface/")
                        )
      ))
   ))



;;  make the var buffer local  huh????

;; find-line-by-string
;; file-under-p
;; file-under-p
(defun find-file-in-cscope (filename cscope-files-file prefix)
  ""
  (let ((line (or
               (find-line-by-string (concat "/" filename) cscope-files-file)
               (find-line-by-string filename cscope-files-file))))
    (if line
        (concat prefix line)
      nil)))

(defadvice ffap-c-mode (around cscope)
  ;; name is the arg.
  "consult cscope.files"
  ad-do-it
  (unless ad-return-value
    ;;      (ffap-locate-file name t ffap-c-path))
    (setq ad-return-value
          (let ((cwd (file-name-directory (buffer-file-name))))
            (cond
             ((file-under-p cwd "~/italia")
              (find-file-in-cscope name
                                   "~/italia/cscope.files"
                                   "~/italia/"))

             ((or (file-under-p cwd "~/next")
                  (file-under-p cwd "/home/maruska/next"))
              (find-file-in-cscope name
                                   "~/next/cscope.files"
                                   "~/next/"))
             (t
              nil))))))

;;; tabs

;;; documentation:
(defun gtk-doc (symbol)
  "grab the symbol under the point (interpret it as a gtk+ function name),
and invoke a html browser to display the relevant API docs  "
  (interactive (list (thing-at-point 'symbol)))
  (if (string-match "-" symbol)
      (setq symbol (replace-regexp-in-string "-" "_" symbol)))
  (cond
   ((string-match "^q" symbol)
    (browse-url-elinks
     (compose-path "file:///opt/qt-4.7.0-beta1/doc/html"
                   (concat (downcase symbol) ".html"))))
   (t; else
    (xterm nil (format "gnome-doc %s" symbol) symbol))))

;;(call-process "/x/activity/shell/gtk" nil nil nil symbol)
(defun invert-word-separator (start end)
  (interactive "r")
  ;; find-out in what direction (- -> _  or reverse)
  (save-excursion
    (goto-char start)
    (let* ((lispy (search-forward "_" end 't)) ; do we want lispy now ?
           (from (if lispy "_" "-"))
           (to (if lispy "-" "_")))
      (do-replace-string from to nil start end))))


(global-set-key [(alt ?-)] 'invert-word-separator)
(global-set-key [(alt ?.)] 'gtk-doc)

; c-mode-hook
(defun my-c-mode-hook ()
  "Common part for C and C++ modes."
  (let ((filename (buffer-file-name))
        )
    ;;(electric)
    ;; simple; anything starting the line but these:
    (set (make-variable-buffer-local 'outline-regexp) "[^{} \t#\n]")
    ;; what? add or remove the space in  "f (x)"?
    (require 'mmc-c-mode-patches)
    ;; force the C++ mode:
    (if (and (or
              (string-match "fork-plugin/src/.*\\.h" filename)
              (string-match "/perforce/" filename))
             (not (eq major-mode 'c++-mode)))
        (c++-mode)
      ;; should only run once:
      (decide-c-style-by-path filename)
      (decide-for-c-include-path filename))))


;(add-hook 'c-mode-hook 'my-c-mode-hook)
;(add-hook 'c++-mode-hook 'my-c-mode-hook)
; (remove-hook 'c++-mode-hook 'my-c-mode-hook)

(add-hook 'c-mode-common-hook 'my-c-mode-hook)

; (remove-hook 'c-mode-hook 'my-c-mode-hook)
;; I'm not ready: Java-mode stopped having font-lock !

;; (add-hook 'java-mode-hook 'my-c-mode-hook)
;; (remove-hook 'java-mode-hook 'my-c-mode-hook)
;;(remove-hook 'c-mode-common-hook 'my-c-mode-hook)

;; c++-mode-hook

(copy-face 'font-lock-th-face 'font-lock-string-face)

(require 'mmc-gud)
(require 'mmc-c-mode-patches)

(provide 'mmc-c-mode)
