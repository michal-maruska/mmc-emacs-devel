
;;;Font-lock for Android init*.rc files:

;; font-lock-keywords

(set-face-foreground 'font-lock-section-face "magenta")


(define-derived-mode android-init-mode sh-mode
  "mode to edit Android init.rc files"

;; todo: not in comments! so not prepend, but?
  )

(font-lock-add-keywords 'android-init-mode
    '(
      ;; early-boot\||
      ;; \\(init\||boot\\)
      ("\\<on \\(early-init\\|init\\|boot\\|early-boot\\|\\(early-\\|post-\\)?fs\\(-data\\)?\\)"
       1 font-lock-section-face prepend)

      ("\\<service \\([-a-z_]+\\)" 1 font-lock-function-name-face prepend)
      ("\\<on \\(property:\\([a-zA-Z_]+\\.?\\)+\\)" 1 font-lock-important prepend)

      ("\\<\\(import\\|write\\|symlink\\|mkdir\\|mount\\(_all\\)?\\|chown\\|chmod\\|copy\\|\\)\\b" 1 font-lock-keyword-face )
      ;; prepend
      )
    )



;; removing failures:
(font-lock-remove-keywords 'sh-mode
  '(
    ("\\<on \\(early-\\(init||boot\\)\\|init\\|boot\\)" 1 font-lock-section-face prepend)


    ("\\<on \\(early-init\\|init\\|early-boot||boot\\)"
     1 font-lock-section-face prepend)

    ("\\<on \\(early-init\\|init\\|early-boot||boot\\)" 1 font-lock-section-face prepend)
    ("\\<on \\(early-\\(init||boot\\)\\|init\\|boot\\)" 1 font-lock-section-face prepend)


    ("\\<on \\(early-init\\|init\\|early-boot||boot\\)"
     1 font-lock-section-face prepend)
    ("\\<on \\(early-init\\|init\\|early-boot\||boot\\)" 1 font-lock-warning-face prepend)
    ("\\<on \\(early-init\\|boot\\|init\\)" 1 font-lock-warning-face prepend)
    ("\\<service \\([a-z]+\\)" 1 font-lock-warning-face prepend)
    ("\\<service \\([a-z]+\\)" 1 font-lock-function-name-face prepend)
    ("\\<service \\([a-z_]+\\)" 1 font-lock-function-name-face prepend)
    ("\\<(import\\|write\\|symlink\\|mkdir\\|mount\\)" 1 font-lock-keyword-face prepend)
    ("\\<\\(import\\|write\\|symlink\\|mkdir\\|mount\\|chown\\|chmod\\|copy\\|\\)" 1 font-lock-keyword-face prepend)
    ("\\<\\(import\\|write\\|symlink\\|mkdir\\|mount\\|chown\\|chmod\\)"
     1 font-lock-keyword-face prepend)
    ("\\<\\(import\\|write\\|symlink\\|mkdir\\|mount\\)"
     1 font-lock-keyword-face prepend)
    ("\\<\\(import\\|write\\|symlink\\|mkdir\\|mount\\|chown\\|chmod\\|copy\\|\\)" 1 font-lock-keyword-face )
    ("\\<\\(import\\|write\\|symlink\\|mkdir\\|mount\\|chown\\|chmod\\|copy\\|\\)\b" 1 font-lock-keyword-face )


    ("\\<on \\(property:\\([a-zA-Z_]+.?\\)+\\)" 1 font-lock-important prepend)
    ("\\<on \\(property:\\([a-z_]+.?\\)+\\)" 1 font-lock-important prepend)
    ))

(provide 'mmc-android)
