
;; for sure you need:
(require 'tempo)


;; i have in  ~/emacs/my-scheme.el:

;; (eval-after-load
;;     "scheme"
;;   '(progn
;;      ....
;;      (load "~/emacs/tempo/scheme.el")
;;      ....



(defvar scheme-tempo-tags nil "tempo needs a table of TAGS.")

(defun scheme-init-tags ()
  "activate the right table of TAGS for `tempo'"
  (setq tempo-match-finder "(\\([^\\b]+\\)\\=")
  (message "activating TEMPO in scheme mode.")
  ;; in every buffer?
  (tempo-use-tag-list 'scheme-tempo-tags)
  ;(tempo-
  )

(add-hook 'scheme-mode-hook 'scheme-init-tags)

;; same trick as abbrevs use:
(define-key scheme-mode-map " " 'tempo-space)
;; (lookup-key scheme-mode-map " ")
;; (local-key-binding " ")
;; (define-module 

;; (lookup-key  " ")
;; (local-key-binding


;;; [10 apr 05]  pflanze: 
(tempo-define-template
 ;; name:
 "l"                                    ;ambda
 '("lambda ("p ")" n>
   ")"
   )
 ;; tag
 "lambda"                                    ;??
 ;; docum:
 ""
 'scheme-tempo-tags)




;;  scsh
(tempo-define-template
 "define-structure"
 '("define-structure " p n>
   "(export " p n> ")" n>
   "(open " p n>
   "scsh" n>
   "scheme" n>
   ")" n> "(files " p ")" n>")")
 "define-structure"
 "Insert a defun expression"
 'scheme-tempo-tags)

(defconst gauche-top-dir (expand-file-name "~/gauche"))


;;  "/a/b" - "/a/" = b
(defun file-name-minus (filename path)
  filename)
;; Get the path from 
;; file-name-directory
;; (buffer-file-name (current-buffer))

;; gauche:
(tempo-define-template
 "define-module"

 '("define-module "
   ;; I want to be prompted, but the suggestion should be  file-name minus  ~/gauche/ prefix!
   (let ((file (buffer-file-name)))
     ;; remove  .scm
     (setq file
           (if (string-match "/home/mmc/gauche/gg/gauche-[^/]*/\\(.*\\)\\.scm" file)
               (match-string 1 file)
             ""))
     (setq file (replace-regexp-in-string "/"  "." file))
     (let ((name (read-from-minibuffer "module-name? " file)))
       (tempo-save-named 'module-name name))
     '(s module-name))
   ;(P "module-name? " module-name nil)
   n>
   "(export "  n> ")" n>
   ";(use )"n>
;   "(use " p ")" n>                     ; cycle !!
   ")" n> "(select-module " (s module-name) ")" n>
   p n> n>
   ;(message "%s" tempo-named-insertions)
   ;;fixme: i should move to the EOB !!

   ;; fixme:  paredit ... I should remove the trailing ")"

   "(provide \"" (translate-module-to-filename (tempo-lookup-named 'module-name) "/") "\"" ; paredit )
   ;((module-name . pg.dependency))
   ;; (s module-name)
   )
 "define-module"
 "Insert a defun expression"
 'scheme-tempo-tags)

;; scheme-tempo-tags
;; (remassoc "define-module" scheme-tempo-tags)
;; (tempo-template-define-module)


(tempo-define-template
 "with-handler"
 '("with-handler " "(lambda (c next)" n>
   p ")" n>
   "(lambda () "n>
   ;; here region.
  p ")" n>
  )
 "with-handler"
 "Insert a handle expression"
 'scheme-tempo-tags)



(tempo-define-template
 "for-each"
 '("for-each " n>
   "(lambda (" p ")" p n>
   ")" n> 
   p")" n>
   )
 "for-each"
 ""
 'scheme-tempo-tags)


(tempo-define-template
 "call-with-current-continuation"
 '(
   "call-with-current-continuation" n>
   "(lambda (cont)" n>
   p n>
   "))"
   )
 "call-with-current-continuation"
 ""
 'scheme-tempo-tags)



(tempo-define-template
 "define-syntax"
 '("define-syntax " p n>
   "(syntax-rules ()" n>
   "((_ " p
   "))))"
   )
 "define-syntax"
 ""
 'scheme-tempo-tags)


(tempo-define-template
 "spawn"
 '("spawn " n>
   "(lambda ()" n>
   "(" p
   "))"
   )
 "spawn"
 ""
 'scheme-tempo-tags)


(tempo-define-template
 "make-thread"
 '("make-thread " n>
   "(lambda ()" n>
   "(" p
   "))"
   )
 "make-thread"
 ""
 'scheme-tempo-tags)

