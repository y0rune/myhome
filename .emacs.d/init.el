; Packages

;; package archives
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives
      '(
        ("ELPA"  . "http://tromey.com/elpa/")
        ("gnu"   . "http://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("ORG"   . "https://orgmode.org/elpa/")
        )
      )
(package-initialize)

;; install use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  )

;; Set path to store "custom-set"
(setq custom-file "~/.emacs.d/emacs-custom.el")

;; Theme
(use-package vscode-dark-plus-theme
  :ensure t
  :config
  (load-theme 'vscode-dark-plus t))

;; Auto enable markdown into html previewOB
(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-interval 5
        auto-package-update-delete-old-verions t)
  (auto-package-update-maybe)
  )

(use-package impatient-mode
  :ensure t
  :mode
  (
   ("\\.md\\'" . impatient-mode)
   )
  :hook
  (
   (impatient-mode . html-mode)
   )
  :config
  (add-hook 'html-mode-hook
	    (lambda ()
              (unless (get-process "httpd")
                (message "starting httpd server...")
                (httpd-start)
                )  
            (impatient-mode)         
	    (imp-set-user-filter 'markdown-html)
	    (imp-visit-buffer)
            )
       )
  )

(global-set-key (kbd "C-x g") 'magit-status)

(defun markdown-html (buffer)
  (princ (with-current-buffer buffer
    (format "<!DOCTYPE html><html><title>Impatient Markdown</title><xmp theme=\"united\" style=\"display:none;\"> %s  </xmp><script src=\"http://strapdownjs.com/v/0.2/strapdown.js\"></script></html>" (buffer-substring-no-properties (point-min) (point-max))))
  (current-buffer)))
