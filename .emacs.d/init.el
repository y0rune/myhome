;Packages

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

(global-set-key (kbd "C-x j") 'awesome-tab-backward-tab)
(global-set-key (kbd "C-x k") 'awesome-tab-forward-tab)

;; 80-charaters mode 
(add-hook 'text-mode-hook 'auto-fill-mode)
(setq-default fill-column 80)

(add-hook 'org-mode-hook '(lambda () (setq fill-column 80)))
(add-hook 'org-mode-hook 'auto-fill-mode)

;; Broswer
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "browser-x")


;; Switch-window
(use-package switch-window
  :ensure t
  :config
  (setq
   switch-window-increase 4
   switch-window-input-style 'minibuffer
   switch-window-shortcut-style 'qwerty
   switch-window-threshold 2
   )
  (setq
   switch-window-qwerty-shortcuts
   '( "a" "s" "d" "f" "g" "h" "j" "k" "l")
   )
  :bind
  ([remap other-window] . switch-window)
  )

;; reveal dependency
(use-package htmlize
  :ensure t
  )
(use-package ox-reveal
  :ensure t
  :config
  ;; maybe add auto-installer in the future
  (setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
)

;; Org-Jira
;(use-package org-jira
;  :ensure t
;  )
;(setq jiralib-url "https://localhost/")

;; Theme
(use-package dracula-theme
  :ensure t
  :config
  (load-theme 'dracula t))

;; Sitebar dirred
(use-package dired-sidebar
  :ensure t
  :commands (dired-sidebar-toggle-sidebar))

(require 'dired-sidebar)
(global-set-key (kbd "C-x d") 'dired-sidebar-toggle-sidebar)

;; Magit
(use-package magit
  :ensure t
  :config
  )

(global-set-key (kbd "C-x g") 'magit-status)

;; Markdown-mode
(use-package markdown-mode
  :ensure t
  :config
  )

;; Livedown
;;; sudo npm install -g livedown
;;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-livedown"))
(require 'livedown)

(custom-set-variables
 '(livedown-autostart nil) ; automatically open preview when opening markdown files
 '(livedown-open t)        ; automatically open the browser window
 '(livedown-port 1337)     ; port for livedown server
 '(livedown-browser nil))  ; browser to use
(global-set-key (kbd "C-M-m") 'livedown-preview)

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
