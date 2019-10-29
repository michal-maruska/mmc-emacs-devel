(add-to-list 'ffap-alist
             '(sh-mode . zsh-find-function))

(if (boundp 'sh-shell-arg)
    (setcdr (assoc 'zsh sh-shell-arg) "-feu"))


(defun zsh-find-function (function)
  "Ask Zsh(1) in a subprocess, for the location of named function
 (its source code)"
  (let ((output (shell-command-to-string
                 (concat "zsh  -c 'echo $^fpath/"
                         function"(N)'"))))
    (if (> (length output) 2)
        (substring output 0 (- (length output) 1)))))


(eval-when-compile
  (require 'skeleton)
  )
;; change the } to ] (unconditional)
(define-skeleton sh-while-getopts
  "Insert a while getopts loop.  See `sh-feature'.
Prompts for an options string which consists of letters for each recognized
option followed by a colon `:' if the option accepts an argument."
  (bash sh-modify sh
        18 "${0##*/}")
  (csh nil
       "while( 1 )" \n
       > "switch( \"$1\" )" \n
       '(setq input '("- x" . 2))
       > >
       ( "option, %s: "
         < "case " '(eval str)
         '(if (string-match " +" str)
              (setq v1 (substring str (match-end 0))
                    str (substring str 0 (match-beginning 0)))
            (setq v1 nil))
         str ?: \n
         > "set " v1 & " = $2" | -4 & _ \n
         (if v1 "shift") & \n
         "breaksw" \n)
       < "case --:" \n
       > "shift" \n
       < "default:" \n
       > "break" \n
       resume:
       < < "endsw" \n
       "shift" \n
       < "end" \n)
  (ksh88 sh-modify sh
         16 "print"
         18 "${0##*/}"
         37 "OPTIND-1")
  (posix sh-modify sh
         18 "$(basename $0)")
  (sh "optstring: "
      > "while getopts :" str " OPT; do" \n
      > "case $OPT in" \n
      '(setq v1 (append (vconcat str) nil))
      ( (prog1 (if v1 (char-to-string (car v1)))
          (if (eq (nth 1 v1) ?:)
              (setq v1 (nthcdr 2 v1)
                    v2 "\"$OPTARG\"")
            (setq v1 (cdr v1)
                  v2 nil)))
        > str "|+" str sh-non-closing-paren \n
        > _ v2 \n
        > ";;" \n)
      > "*" sh-non-closing-paren \n
      > "echo" " \"usage: " "`basename $0`"
      " [+-" '(setq v1 (point)) str
      '(save-excursion
         (while (search-backward ":" v1 t)
           (replace-match " ARG] [+-" t t)))
      (if (eq (preceding-char) ?-) -5)
      (if (and (sequencep v1) (length v1)) "] " "] ") ;; mmc!
      "[--] ARGS...\"" \n
      "exit 2"  > \n
      "esac" >
      \n "done"
      > \n
      "shift " (sh-add "OPTIND" -1) \n
      "OPTIND=1" \n))

;; from sh-mode.el
;; /usr/share/emacs/24.4.50/lisp/progmodes/sh-script.el.gz
(define-skeleton sh-getopt
  "Insert a while getopt loop.  See `sh-feature'.
Prompts for an options string which consists of letters for each recognized
option followed by a colon `:' if the option accepts an argument."
  (bash sh-modify sh
        18 "${0##*/}")
  ;; (csh nil
  ;;      "while( 1 )" \n
  ;;      > "switch( \"$1\" )" \n
  ;;      '(setq input '("- x" . 2))
  ;;      > >
  ;;      ( "option, %s: "
  ;;     < "case " '(eval str)
  ;;     '(if (string-match " +" str)
  ;;          (setq v1 (substring str (match-end 0))
  ;;                str (substring str 0 (match-beginning 0)))
  ;;        (setq v1 nil))
  ;;     str ?: \n
  ;;     > "set " v1 & " = $2" | -4 & _ \n
  ;;     (if v1 "shift") & \n
  ;;     "breaksw" \n)
  ;;      < "case --:" \n
  ;;      > "shift" \n
  ;;      < "default:" \n
  ;;      > "break" \n
  ;;      resume:
  ;;      < < "endsw" \n
  ;;      "shift" \n
  ;;      < "end" \n)
  ;; (ksh88 sh-modify sh
  ;;     16 "print"
  ;;     18 "${0##*/}"
  ;;     37 "OPTIND-1")
  ;; (posix sh-modify sh
  ;;     18 "$(basename $0)")
  (sh "optstring: "

      "cmd_options=$(getopt --name $0 --shell " "bash" \n
      > "--longoptions" @ \n
      > "--options" @   \n
      "--" "\"$@\""
      ") || { usage && exit 1 }"
      \n
      "eval set -- \"$cmd_options\"" \n
      "while (( $# > 0 )) "  "do" \n
      "shift"
      ;; case

      "--) break"
      "done"
      \n
      "#process_rest \"$@\""
      )

      ;; > "while getopts :" str " OPT; do" \n
      ;; > "case $OPT in" \n
      ;; '(setq v1 (append (vconcat str) nil))
      ;; ( (prog1 (if v1 (char-to-string (car v1)))
      ;;          (if (eq (nth 1 v1) ?:)
      ;;              (setq v1 (nthcdr 2 v1)
      ;;                    v2 "\"$OPTARG\"")
      ;;            (setq v1 (cdr v1)
      ;;                  v2 nil)))
      ;;        > str "|+" str sh-non-closing-paren \n
      ;;        > _ v2 \n
      ;;        > ";;" \n)
      ;; > "*" sh-non-closing-paren \n
      ;; >
      ;; "echo" ;; 16
      ;; " \"usage: "
      ;; "`basename $0`" ; here not basename but  ${0##~/}?
      ;; " [+-" '(setq v1 (point)) str
      ;; '(save-excursion
      ;;         (while (search-backward ":" v1 t)
      ;;           (replace-match " ARG] [+-" t t)))
      ;; (if (eq (preceding-char) ?-) -5)
      ;; (if (and (sequencep v1) (length v1)) "] " "} ")
      ;; "[--] ARGS...\"" \n
      ;; "exit 2"  > \n
      ;; "esac" >
      ;; \n "done"
      ;; > \n
      ;; "shift " (sh-add "OPTIND" -1)	; 37 why ksh88 shortcut? different?
      ;; \n
      ;; "OPTIND=1" \n)
  )

(provide 'mmc-shell)
