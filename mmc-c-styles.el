(require 'cc-mode)
(require 'assoc)
(require 'cc-guess nil 'noerror)

;; so these don't set/use c-basic-offset ??
;; (set to 2 or 4). Maybe inherit from ...?

;; 2013/5  so, C-style talks about + - skips; those
;; are relative to/in units of "c-basic-offset spaces"
;; then spaces/tab is dependent (like I/O)
;; on indent-tabs-mode and tab-width.
;;
;; c-basic-offset     ... how much spaces + c-offsets-alist
;; indent-tabs-mode   ... use `TAB-compression' JZW
;;
;; (setq tab-width 4) ... tab char in the file: (the compression factor)

;; (c-get-style-variables "gnu")
;; c-style-alist
;; c-style-variables
;;  c-indentation-style -- internal.
;; c-cleanup-list  .. todo!


;; modify the "Linux" style to insert <TAB>s !

;; c-insert-tab-function     tab-to-tab-stop
;; indent-tabs-mode          t

;; make it insert TABs!

;; This rewrites the upstream linux style!
(let ((l (aget c-style-alist "linux")))
  (unless (aget l 'indent-tabs-mode)
    ;; (x y ...) -> (x Z y ...)
    (setcdr l
        (cons
         '(indent-tabs-mode . t)
         (cdr l)))))

;; add paren-space-brace into 'c-cleanup-list:
;;  "){" -> ") {"
;; with newline in between?
(let* ((l (aget c-style-alist "linux"))
       (cleanup (aget l 'c-cleanup-list)))
  (unless
      (memq 'paren-space-brace cleanup)
    (setcdr cleanup
        (cons
         'paren-space-brace
         (cdr cleanup)))))
;; to accomplish in the current-buffer local style:
;; (add-to-list 'c-cleanup-list 'paren-space-brace)


;; I guess `obsolete' now!
(defun tomtom-hook (filename)
  "adapt to tomtom style for C"
  (interactive)
  ;; when loading & saving
  ;; (setq indent-tabs-mode t)
  (if (eq major-mode 'java-mode)
      (setq c-basic-offset 4
            indent-tabs-mode t)
    ;; mmc: this is only about the `compression' part of TAB.
    (setq tab-width 8
          ;; when indenting myself:
          ;; c-basic-offset 8
          )
    ;; fixme: useless after setting the style!
    (if (functionp 'c-guess-buffer)
        (c-guess-buffer)))


  (if (string-match "/bmw/" filename)
      (if (string-match "ReferenceReflectionContext" filename)
          (setq indent-tabs-mode t)
        (setq indent-tabs-mode nil))))

;;;
;; Some customization is not part of the style, but a separate variable, so done in the hook:
;; (setq indent-tabs-mode t)

(c-add-style
 "tomtom"
 '((c-tab-always-indent        . t)         ; TAB just indents
   (c-basic-offset . 4)                     ;fixme: 8 for some sources!
   (c-comment-only-line-offset . 0)         ; only comment -> additional offset

   ;; when I press { I want to insert a newline BEFORE or AFTER:
   ;; in java mode I don't want hanging at: ((func-decl-cont 5425))
   ;; (substatement-open . (after))
   (c-hanging-braces-alist     . ((substatement-open after)
                                  ;;
                                  (topmost-intro after) ;this is after a: void function() .{
                                  (inline-open after)

                                  (brace-list-open) ;no newline around!
                                  (defun-open after)
                                  (func-decl-cont after) ;newline After the {
                                  ))
   (c-hanging-colons-alist     . ((member-init-intro before)
                                  (inher-intro)
                                  (case-label after)
                                  (label after)
                                  (access-label after)))
   (c-cleanup-list             . (scope-operator
                                  no-space-before-funcall
                                  empty-defun-braces
                                  defun-close-semi
                                  ;; if ()_{
                                  paren-space-brace
                                  ))
   ;; C++ so
   (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
                                  (substatement-open . 0)

                                  ;; November 2018 -- for NavApp
                                  ;; (case-label        . 4)
                                  (case-label        . +)
                                  ;;  2 ->
                                  (statement-case-intro . +)
                                  (statement-cont . ++)
                                  ;; android code probably different.
                                  ;; (arglist-cont-nonempty . ++) ;n4f!
                                  (arglist-cont-nonempty . 4)
                                  (substatement . +)

                                  ;; (case-label . 0)

                                  (block-open        . 0)
                                  (knr-argdecl-intro . -)



                                  ;; namespace-open
                                  ;; innamespace  .... ignore it!
                                  ;; (substatement  . 2)

                                  ;; Java +,   C 2?
                                  (statement-block-intro . +)
                                  (innamespace . 0)
                                  (inline-open 0)

                                  ;; diff between these 2?
                                  (inclass . +)     ; java +, maybe C++  2?
                                  (inexpr-class . 0)    ; java +, maybe C++  2?

                                  (defun-block-intro . +) ; maybe C 2, but Java +
                                  (label . 0)

                                  ;; problem:  if a b; else c;    if after b we have ";" then
                                  ;; relative to "if", otherwise relative to  "b" !!
                                  ;;
                                  ;; 2011-02-24 for some reason I had -2
                                  ;; but
                                  (else-clause 0)
                                  (topmost-intro-cont 0)
                                  (access-label . -2) ; - inclass
                                  (topmost-intro . 0)
                                  (member-init-intro . 2)))

   (c-echo-syntactic-information-p . t)))


(c-add-style "t++"
 ;; Tomtom c++
 ;; this is not a style variable, so done in a hook:(
 ;; (setq indent-tabs-mode t)
 '((c-tab-always-indent        . t)     ; TAB just indents
   (c-basic-offset . 2)                 ;fixme: 8 for some sources!
   (c-comment-only-line-offset . 0)     ; only comment -> additional offset


   ;; when I press { I want to insert a newline BEFORE or AFTER:
   ;; in java mode I don't want hanging at: ((func-decl-cont 5425))
   ;; (substatement-open . (after))
   ;; C-c C-o
   (c-hanging-braces-alist     . ((substatement-open before after)
                                  ;; fixme! how to remove the dangling space!

                                  (topmost-intro after) ;this is after a: void function() .{
                                  (inline-open after)

                                  (brace-list-open) ;no newline around!
                                  (defun-open after)
                                  (func-decl-cont after) ;newline After the {
                                  ))
   (c-hanging-colons-alist     . ((member-init-intro before)
                                  (inher-intro)
                                  (case-label after)
                                  (label after)
                                  (access-label after)))
   (c-cleanup-list             . (scope-operator
                                  no-space-before-funcall
                                  empty-defun-braces
                                  defun-close-semi
                                  ;; if ()_{
                                  paren-space-brace
                                  ))
   ;; C++ so
   (c-offsets-alist            . (

                                  (arglist-intro . 12)
                                  (case-label . +)
                                  ;; (topmost-intro . 0)
                                  (innamespace . +)
                                  ;;
                                  ; (arglist-cont-nonempty )

                                  (arglist-close . c-lineup-arglist)
                                  (substatement-open . 0)
                                  (block-open        . 0)
                                  (knr-argdecl-intro . -)

                                  ;; android code probably different.
                                  ;(arglist-cont-nonempty . ++) ;n4f!


                                  ;; namespace-open
                                  ;; innamespace  .... ignore it!
                                  (substatement  . 2)

                                  ;; Java +,   C 2?
                                  (statement-block-intro . +)
                                  ;; (innamespace . 0)
                                  (inline-open 0)

                                  ;; diff between these 2?
                                  (inclass . +)      ; java +, maybe C++  2?
                                  (inexpr-class . 0) ; java +, maybe C++  2?

                                  (defun-block-intro . +) ; maybe C 2, but Java +
                                  (label . 0)

                                  ;; problem:  if a b; else c;    if after b we have ";" then
                                  ;; relative to "if", otherwise relative to  "b" !!
                                  ;;
                                  ;; 2011-02-24 for some reason I had -2
                                  ;; but
                                  (else-clause 0)
                                  (topmost-intro-cont 0)
                                  (access-label . -2) ; - inclass
                                  (case-label . 0)
                                  (statement-case-intro . 2)
                                  (member-init-intro . 2)))

   (c-echo-syntactic-information-p . t)))

(c-add-style
 "sane"
 ;; this is not a style variable, so done in a hook:(
 ;; (setq indent-tabs-mode t)
 '((c-tab-always-indent        . t)     ; TAB just indents
   (c-basic-offset . 2)                 ;fixme: 8 for some sources!
   (c-comment-only-line-offset . 0)     ; only comment -> additional offset


   ;; when I press { I want to insert a newline BEFORE or AFTER:
   ;; in java mode I don't want hanging at: ((func-decl-cont 5425))
   ;; (substatement-open . (after))
   ;; C-c C-o
   (c-hanging-braces-alist     . ((substatement-open before after)
                                  ;; fixme! how to remove the dangling space!

                                  (topmost-intro after) ;this is after a: void function() .{
                                  (inline-open after)

                                  (brace-list-open) ;no newline around!
                                  (defun-open after)
                                  (func-decl-cont after) ;newline After the {
                                  ))
   (c-hanging-colons-alist     . ((member-init-intro before)
                                  (inher-intro)
                                  (case-label after)
                                  (label after)
                                  (access-label after)))
   (c-cleanup-list             . (scope-operator
                                  no-space-before-funcall
                                  empty-defun-braces
                                  defun-close-semi
                                  ;; if ()_{
                                  paren-space-brace
                                  ))
   (c-auto-newline . t)
   ;; C++ so
   (c-offsets-alist            . (

                                  (arglist-cont-nonempty . 5)
                                  (substatement-open . 2)
                                  (substatement-label . 2)
                                  (case-label . 2)

                                  (arglist-intro . c-lineup-arglist-intro-after-paren) ;; 12
                                  (arglist-cont . c-lineup-arglist-intro-after-paren)
                                  ;; fixme: see above 5
                                  (arglist-cont-nonempty . c-lineup-arglist-intro-after-paren)
                                  (arglist-close . c-lineup-arglist)


                                  (case-label . +)
                                  ;; (topmost-intro . 0)
                                  (innamespace . +)
                                  ;;

                                  (case-label        . 4)
                                  (block-open        . 0)
                                  (knr-argdecl-intro . -)

                                  ;; android code probably different.
                                  ;(arglist-cont-nonempty . ++) ;n4f!


                                  ;; namespace-open
                                  ;; innamespace  .... ignore it!
                                  (substatement  . 2)

                                  ;; Java +,   C 2?
                                  (statement-block-intro . +)
                                  ;; (innamespace . 0)
                                  (inline-open 0)

                                  ;; diff between these 2?
                                  (inclass . +)      ; java +, maybe C++  2?
                                  (inexpr-class . 0) ; java +, maybe C++  2?

                                  (defun-block-intro . +) ; maybe C 2, but Java +
                                  (label . 0)

                                  ;; problem:  if a b; else c;    if after b we have ";" then
                                  ;; relative to "if", otherwise relative to  "b" !!
                                  ;;
                                  ;; 2011-02-24 for some reason I had -2
                                  ;; but
                                  (else-clause 0)
                                  (topmost-intro-cont 0)
                                  (access-label . -2) ; - inclass
                                  (case-label . 0)
                                  (statement-case-intro . 2)
                                  (member-init-intro . 2)))
   (c-echo-syntactic-information-p . t)))

(c-add-style "sane"
 ;; this is not a style variable, so done in a hook:(
 ;; (setq indent-tabs-mode t)
 '((c-tab-always-indent        . t)     ; TAB just indents
   (c-basic-offset . 2)                 ;fixme: 8 for some sources!
   (c-comment-only-line-offset . 0)     ; only comment -> additional offset


   ;; when I press { I want to insert a newline BEFORE or AFTER:
   ;; in java mode I don't want hanging at: ((func-decl-cont 5425))
   ;; (substatement-open . (after))
   ;; C-c C-o
   (c-hanging-braces-alist     . ((substatement-open before after)
                                  ;; fixme! how to remove the dangling space!

                                  (topmost-intro after) ;this is after a: void function() .{
                                  (inline-open after)

                                  (brace-list-open) ;no newline around!
                                  (defun-open after)
                                  (func-decl-cont after) ;newline After the {
                                  ))
   (c-hanging-colons-alist     . ((member-init-intro before)
                                  (inher-intro)
                                  (case-label after)
                                  (label after)
                                  (access-label after)))
   (c-cleanup-list             . (scope-operator
                                  no-space-before-funcall
                                  empty-defun-braces
                                  defun-close-semi
                                  ;; if ()_{
                                  paren-space-brace
                                  ))
   (c-auto-newline . t)
   ;; C++ so
   (c-offsets-alist            . (

                                  (arglist-cont-nonempty . 5)
                                  (substatement-open . 2)
                                  (substatement-label . 2)
                                  (case-label . 2)

                                  (arglist-intro . 12)
                                  (case-label . +)
                                  ;; (topmost-intro . 0)
                                  (innamespace . +)
                                  ;;
                                  ; (arglist-cont-nonempty )

                                  (arglist-close . c-lineup-arglist)
                                  (case-label        . 4)
                                  (block-open        . 0)
                                  (knr-argdecl-intro . -)

                                  ;; android code probably different.
                                  ;(arglist-cont-nonempty . ++) ;n4f!


                                  ;; namespace-open
                                  ;; innamespace  .... ignore it!
                                  (substatement  . 2)

                                  ;; Java +,   C 2?
                                  (statement-block-intro . +)
                                  ;; (innamespace . 0)
                                  (inline-open 0)

                                  ;; diff between these 2?
                                  (inclass . +)      ; java +, maybe C++  2?
                                  (inexpr-class . 0) ; java +, maybe C++  2?

                                  (defun-block-intro . +) ; maybe C 2, but Java +
                                  (label . 0)

                                  ;; problem:  if a b; else c;    if after b we have ";" then
                                  ;; relative to "if", otherwise relative to  "b" !!
                                  ;;
                                  ;; 2011-02-24 for some reason I had -2
                                  ;; but
                                  (else-clause 0)
                                  (topmost-intro-cont 0)
                                  (access-label . -2) ; - inclass
                                  (statement-case-intro . 2)
                                  (member-init-intro . 2)))

   (c-echo-syntactic-information-p . t)))


(c-add-style "dui"
 '((c-cleanup-list             . (no-space-before-funcall
                                  brace-else-brace))))

(c-add-style "xorg"
 '((c-basic-offset . 4)
   (c-tab-always-indent        . t)     ; TAB just indents
   (c-comment-only-line-offset . 0)     ; only comment -> additional offset

   (c-hanging-braces-alist     . ((substatement-open after)
                  (brace-list-open)))
   (c-hanging-colons-alist     . ((member-init-intro before)
                  (inher-intro)
                  (case-label after)
                  (label after)
                  (access-label after)))
   (c-cleanup-list             . (scope-operator
                  no-space-before-funcall
                  empty-defun-braces
                  defun-close-semi
                  paren-space-brace))
   ;;
   (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
                  (substatement-open . 0)
                  (case-label        . 4)
                  (block-open        . 0)
                  (knr-argdecl-intro . -)))
   (c-echo-syntactic-information-p . t)))


(c-add-style "rxvt"
 '((c-tab-always-indent        . t)     ; TAB just indents
   ;;c-basic-offset
   (c-comment-only-line-offset . 0)     ; only comment -> additional offset

   (c-hanging-braces-alist     . ((substatement-open after)
                  (brace-list-open)))
   (c-hanging-colons-alist     . ((member-init-intro before)
                  (inher-intro)
                  (case-label after)
                  (label after)
                  (access-label after)))
   (c-cleanup-list             . (scope-operator
                  no-space-before-funcall
                  empty-defun-braces
                  defun-close-semi
                  paren-space-brace))
   ;;
   (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
                  (substatement-open . 0)
                  (case-label        . 4)
                  (block-open        . 0)
                  (knr-argdecl-intro . -)))
   (c-echo-syntactic-information-p . t)))


(c-add-style "android-java"
 '(
   ;; copied from "java"
   (c-basic-offset . 4)
   (c-comment-only-line-offset . (0 . 0))
   ;; the following preserves Javadoc starter lines
   (c-offsets-alist . ((inline-open . 0)
                       (topmost-intro-cont    . +)
                       (statement-block-intro . +)
                       (knr-argdecl-intro     . 5)
                       (substatement-open     . +)

                       (substatement-label    . +)
                       (label                 . +)
                       (statement-case-open   . +)
                       (statement-cont        . +)
                       (arglist-intro  . c-lineup-arglist-intro-after-paren)
                       (arglist-close  . c-lineup-arglist)
                       (access-label   . 0)
                       (inher-cont     . c-lineup-java-inher)
                       (func-decl-cont . c-lineup-java-throws)

                       ;; ^^^ java

                                        ;(substatement-open . 0)
                       (case-label        . +)
                       (statement-case-intro +)

                       (block-open        . 0)
                                        ;(knr-argdecl-intro . -)

                       ;; android code probably different.
                       (arglist-cont-nonempty . ++) ;n4f!


                       ;; namespace-open
                       ;; innamespace  .... ignore it!
                       ; (substatement  . 2)

                       ;; Java +,   C 2?
                       (statement-block-intro . +)
                       (innamespace . 0)
                       (inline-open 0)

                       ;; diff between these 2?
                       (inclass . +)                 ; java +, maybe C++  2?
                       (inexpr-class . 0)            ; java +, maybe C++  2?

                       (defun-block-intro . +) ; maybe C 2, but Java +
                       (label . 0)

                       ;; problem:  if a b; else c;    if after b we have ";" then
                       ;; relative to "if", otherwise relative to  "b" !!
                       ;;
                       ;; 2011-02-24 for some reason I had -2
                       ;; but
                       (else-clause 0)
                       (topmost-intro-cont 0)
                       (access-label . -2) ; - inclass
                       (topmost-intro . 0)
                       (member-init-intro . 2)
                       ))

                                        ;(c-tab-always-indent        . t)         ; TAB just indents

   ;; when I press { I want to insert a newline BEFORE or AFTER:
   ;; in java mode I don't want hanging at: ((func-decl-cont 5425))
   ;; (substatement-open . (after))
   (c-hanging-braces-alist     . (
                                  (topmost-intro after) ;this is after a: void function() .{
                                  (inline-open after)

                                  ;; mmc:
                                  ;(statement after)
                                  ;(substatement after)
                                  (substatement-open after)


                                  (brace-list-open) ;no newline around!
                                  (defun-open after)
                                  (func-decl-cont after) ;newline After the {
                                  ))
   (c-hanging-colons-alist     . (
                                  ;; (member-init-intro before)
                                  ;; (inher-intro)
                                  ;; (case-label after)
                                  ;; (label after)
                                  ;; (access-label after)
                                  ))
   (c-cleanup-list             . (
                                  scope-operator
                                  no-space-before-funcall
                                  empty-defun-braces
                                  defun-close-semi
                                  ;; ;; if ()_{
                                  paren-brace
                                  ))

   (c-echo-syntactic-information-p . t)))

;; testbed:
(c-add-style
 "mmctest"
 '((c-tab-always-indent        . t)     ; TAB just indents
   ;;c-basic-offset
   (c-comment-only-line-offset . 0)     ; only comment -> additional offset

   (c-hanging-braces-alist     . ((substatement-open after)
                  (brace-list-open)))
   (c-hanging-colons-alist     . ((member-init-intro before)
                  (inher-intro)
                  (case-label after)
                  (label after)
                  (access-label after)))
   (c-cleanup-list             . (scope-operator
                  ;; funny:
                  space-before-funcall
                  empty-defun-braces
                  defun-close-semi
                  paren-space-brace))
   ;;
   (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
                  (substatement-open . 0)
                  (case-label        . 4)
                  (block-open        . 0)
                  (knr-argdecl-intro . -)))
   (c-echo-syntactic-information-p . t)))


(defconst linux-sources-dirs-regexp
  (concat "/git/"
          (regexp-opt '("linux"
                        "nexus10" "nubia" "zuk" "samsung" "e980" "mipad" "freescale-linux")))
  "Used to recognize a pathname leading into the Linux sources")

;; tomtom per-path only for the cscope and 'ffap-c-path (see above).
(defun decide-c-style-by-path (filename)
  "The part which comes after possibly forcing C++ mode.
Decide for a style, based on path."
  ;; avoid duplication, so exit immediately.
  (let ((style
         (cond
          ((string-match "postgresql" (buffer-file-name))
           "bsd")
          ((string-match "/xorg/" filename)
           "xorg")
          ((string-match "/x/" filename)
           "xorg")
          ((string-match "/fork-plugin/src/" filename)
           "xorg")

          ((string-match "/sane" filename)
           ;; c-basic-offset 3
           "sane")
          ((string-match "/sawfish/" filename)
           ;; c-basic-offset 3
           "rxvt")

          ((string-match "/emacs/" filename)
           ;; c-basic-offset 3
                                        ;c-basic-offset 2
           "gnu")

          ((string-match "/less/" filename)
           (setq indent-tabs-mode t)
           "bsd"
           )
          ((or (string-match linux-sources-dirs-regexp filename)
               (string-match "/usr/src/linux" filename)
               (string-match "/git/git-core/" filename)
               (string-match "/git/rsync.*/" filename))
           (setq tab-width 8)
           "linux")


          ;; Components/NavApp/Hmi/NavigationAppLogicLib/Implementation/Tasks/SelectAddress/Panels/git/linux/
          ((or (string-match "/deauville-p4cns-main/" filename)
               (string-match "/wave3/" filename)
                                        ;(string-match "/usr/src/linux" filename)
                                        ;(string-match "/git/git-core/" filename)
               )
           ;;(setq tab-width 8)
           "t++")

          ((or (string-match "/perforce/" filename)
               (string-match "/ngl/" filename)

               (string-match "/next/" filename)
               (string-match "/italia/" filename)
               (string-match "/nav4/" filename)
               (string-match "/gallo/" filename)
               (string-match "/n4f/" filename)
               )
           ;; /home/maruska/ngl/project/arizona2/main/CrossPlatform/
           ;; Framework/PlatformAbstractionLayer/Implementation/DeviceInformation/
           ;; "tomtom"
           "android-java")
          (t
                                        ;"free-group-style"
           nil))))

    (when style
      ;(unless (eq major-mode 'java-mode)
      ;; why?
      (c-set-style style)

      ;; ~/git/xorg/xserver/xkb/freeze-stack.c
      (if (and nil
               (string= style "tomtom"))
          ;;fixme: this should be defined as style!
          (tomtom-hook filename)))

    (if (string-match "/bmw/" filename)
        (if (string-match "ReferenceReflectionContext" filename)
            (setq indent-tabs-mode t)
          (setq indent-tabs-mode nil)))

    ;; often the style is not fully true:

    ;; what's the basic unit of indentation?
    ;; c-basic-offset py-indent-offset

    ;; Java: tab is 2 spaces?
    ;; tab-width 4

    ;; n4f: not tabs.
    (if (string-equal style "sane")
        (setq indent-tabs-mode nil)
      ;; else:
      (if (string-match indent-tabs-mode-matcher filename)
          ;; buffer-local
          (setq indent-tabs-mode t)
        )
      ;; (unless (or t
      ;;             (eq major-mode 'java-mode))
      ;;   (setq indent-tabs-mode t))
      )))

(defconst indent-tabs-mode-matcher
  ; "regexp to match filenames to be used with TABS"
  (regexp-opt (list
               "elinks/"
               "/pcre3"
               )))


(provide 'mmc-c-styles)
