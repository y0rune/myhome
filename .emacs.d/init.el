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

;; Enable awesome-tab-mode
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins"))
(require 'awesome-tab)
(awesome-tab-mode t)

(use-package awesome-tab
  :load-path "~/.emacs.d/plugins"
  :config
  (awesome-tab-mode t))
(awesome-tab-mode t)

;; Theme
(use-package dracula-theme
  :ensure t
  :config
  (load-theme 'dracula t))

;; Magit
(use-package magit
  :ensure t
  :config
  )

(global-set-key (kbd "C-x g") 'magit-status)

;; Auto enable markdown into html previewOB
;(use-package auto-package-update
;  :ensure t
;  :config
;  (setq auto-package-update-interval 5
;        auto-package-update-delete-old-verions t)
;  (auto-package-update-maybe)
;  )


;(use-package impatient-mode
;  :ensure t
;  :mode
;  (
;   ("\\.md\\'" . impatient-mode)
;   )
;  :hook
;  (
;   (impatient-mode . html-mode)
;   )
;  :config
;  (add-hook 'html-mode-hook
;	    (lambda ()
;              (unless (get-process "httpd")
;                (markdown-mode)
;                (message "starting httpd server...")
;                (httpd-start)
;                )  
;            (impatient-mode)         
;	    (imp-set-user-filter 'markdown-html)
;	    (imp-visit-buffer)
;            )
;       )
;  )


;(defun markdown-html (buffer)
;  (princ (with-current-buffer buffer
;    (format "<!DOCTYPE html><html><title>Impatient Markdown</title><xmp theme=\"united\" style=\"display:none;\"> %s  </xmp><script src=\"http://strapdownjs.com/v/0.2/strapdown.j;s\"></script></html>" (buffer-substring-no-properties (point-min) (point-max))))
;  (current-buffer)))

; Livedown
; git clone https://github.com/shime/emacs-livedown.git ~/.emacs.d/emacs-livedown
; sudo npm install -g livedown
(add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-livedown"))
(require 'livedown)

(custom-set-variables
 '(livedown-autostart nil) ; automatically open preview when opening markdown files
 '(livedown-open t)        ; automatically open the browser window
 '(livedown-port 1337)     ; port for livedown server
 '(livedown-browser nil))  ; browser to use
(global-set-key (kbd "C-M-m") 'livedown-preview)

;; Mew
 (autoload 'mew "mew" nil t)
 (autoload 'mew-send "mew" nil t)
 ;; Optional setup (Read Mail menu for Emacs 21):
 (if (boundp 'read-mail-command)
     (setq read-mail-command 'mew))
 ;; Optional setup (e.g. C-xm for sending a message):
 (autoload 'mew-user-agent-compose "mew" nil t)
 (if (boundp 'mail-user-agent)
     (setq mail-user-agent 'mew-user-agent))
 (if (fboundp 'define-mail-user-agent)
     (define-mail-user-agent
       'mew-user-agent
       'mew-user-agent-compose
       'mew-draft-send-message
       'mew-draft-kill
       'mew-send-hook))


;;; --- Look & Feel ---

;; no toolbar:
(tool-bar-mode -1)

;; line numbers:
(global-display-line-numbers-mode 1)

;; scrolling:
(setq scroll-conservatively 100)

;; no "bell" (audible notification):
(setq ring-bell-function 'ignore)

;; highlight:
(global-hl-line-mode 1)

;; auto reloading (reverting) buffers
(global-auto-revert-mode 1)

;; disable lock files:
(setq create-lockfiles nil)

;; disable autosave:
(setq auto-save-default nil)

;; disable backups:
(setq make-backup-files nil)

;; Pass "y or n" instead of "yes or no"
(defalias 'yes-or-no-p 'y-or-n-p)

;; Highlight parens
(show-paren-mode 1)

;; Candy
(global-prettify-symbols-mode 1)

;; Modeline
(column-number-mode 1)
(size-indication-mode 1)

;; Horizontal splitting
(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1)
  )
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)

;; Vertical splitting
(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1)
  )
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

;; Kill & remove split
(defun kill-and-remove-split ()
  "Kill and remove split."
  (interactive)
  (kill-buffer)
  (delete-window)
  (balance-windows)
  (other-window 1)
  )
(global-set-key (kbd "C-x x") 'kill-and-remove-split)
