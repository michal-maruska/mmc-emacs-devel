(require 'cmake-mode)

;; ffap

(defun ffap-cmake-module (name)
  ""
  (let ((cmake-path '("/usr/share/cmake-3.7/Modules/"
                      "/usr/share/cmake-3.7/Modules/Platform/"
                      "./CMake"
                      ))
        (cmake-extensions '(".cmake")))

    (or (ffap-locate-file name cmake-extensions
                          cmake-path)
        (ffap-locate-file (concat "Find" name)
                          cmake-extensions
                          cmake-path))))

(add-to-list 'ffap-alist
             '(cmake-mode . ffap-cmake-module))

;; auto-mode-alist
(add-to-list 'auto-mode-alist '("CMake.*\\.\\(ext\\|txt\\)" . sh-mode))


;; browse
(defun cmake-browse-help (command)
  ""
  (interactive (list (symbol-name (symbol-at-point))))
  (browse-url
   (concat "file:///usr/share/doc/cmake-data/html/command/" command ".html")))


(define-key cmake-mode-map '[(meta control ?m)] 'cmake-help)

;; patches:
(defun cmake-help ()
  "Queries for any of the four available help topics and prints out the approriate page."
  (interactive)
  (let* ((default-entry (cmake-symbol-at-point))
         (command-list (cmake-get-list "command"))
         (variable-list (cmake-get-list "variable"))
         (module-list (cmake-get-list "module"))
         (property-list (cmake-get-list "property"))
         (all-words (append command-list variable-list module-list property-list))
         (input (if (and (not current-prefix-arg)
                         default-entry)
                    default-entry
                    (completing-read
                     "CMake command/module/variable/property: " ; prompt
                     all-words                                  ; completions
                     nil                                        ; predicate
                     t                                          ; require-match
                     default-entry                              ; initial-input
                     'cmake-help-complete-history
                     ))))
    (if (string= input "")
        (error "No argument given")
      (if (member input command-list)
          (cmake-command-run "--help-command" input "*CMake Help*")
        (if (member input variable-list)
            (cmake-command-run "--help-variable" input "*CMake Help*")
          (if (member input module-list)
              (cmake-command-run "--help-module" input "*CMake Help*")
            (if (member input property-list)
                (cmake-command-run "--help-property" input "*CMake Help*")
              (error "Not a know help topic.") ; this really should not happen
              )))))))

(defvar cmake-mode-view-map (make-sparse-keymap "") "")
(set-keymap-parent cmake-mode-view-map cmake-mode-map)
(define-key cmake-mode-view-map [?q]
  (lambda ()
    (interactive)
    (bury-buffer)
    (delete-window)))

(defun cmake-command-run (type &optional topic buffer)
  "Runs the command cmake with the arguments specified.  The
optional argument topic will be appended to the argument list."
  (interactive "s")
  (let* ((bufname (if buffer buffer (concat "*CMake" type (if topic "-") topic "*")))
         (buffer  (if (get-buffer bufname) (get-buffer bufname) (generate-new-buffer bufname)))
         (command (concat cmake-mode-cmake-executable " " type " " topic))
         ;; Turn of resizing of mini-windows for shell-command.
         (resize-mini-windows nil)
         )
    (shell-command command buffer)
    (save-selected-window
      (select-window (display-buffer buffer 'not-this-window))
      (cmake-mode)
      ;;
      (read-only-mode 1)
      (use-local-map cmake-mode-view-map))))

(provide 'mmc-cmake)
