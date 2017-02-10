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

(provide 'mmc-cmake)
