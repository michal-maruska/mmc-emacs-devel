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
      )))

(provide 'mmc-cmake)
