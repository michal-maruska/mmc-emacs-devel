
(require 'mmc-files)

(defun perl-ffap (string)
  (interactive)
  (modify-syntax-entry ?:  "_" (syntax-table))
  ;; (char-syntax ?:)
  ;; (set-syntax "::" symbol)
  (let* ((module-name string)
          ;;(erase-text-properties (symbol-name (symbol-at-point))))
         (relative (add-suffix-optionally
                    (translate-module-to-filename module-name "::")
                    ".pm"))
         (path (find-subpath-in-paths
                relative
                (list "/usr/share/perl5/"))))
    ;;Dpkg::Changelog::Entry;
    path))


(provide 'mmc-perl)
