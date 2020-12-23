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
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; Remove welcome screen
(setq inhibit-startup-screen t)

;; Disable menu
(menu-bar-mode 0)

;; Enable IDO mode
(ido-mode 1)
(global-set-key (kbd "C-x b") 'ido-switch-buffer)

;; Remove working cl
(require 'cl-lib)
(setq byte-compile-warnings '(cl-functions))
(advice-add 'sh-set-shell :around
	    (lambda (orig-fun &rest args)
	      (cl-letf (((symbol-function 'message) #'ignore))
		(apply orig-fun args))))

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

; Global turn on flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

; Org Files
(add-hook 'org-mode-hook '(lambda () (setq fill-column 80)))
(add-hook 'org-mode-hook 'auto-fill-mode)
(add-hook 'org-mode-hook 'turn-on-flyspell)


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

;; Enable japanese
(if (condition-case nil (require 'mozc)(error nil))
  (setq ecb-be-more-like-better-yes-p t)
  (message "Monz not available; not configuring") )
(setq default-input-method "japanese-mozc")

;; Enable Smex
(use-package smex
  :ensure t
  :init
  (smex-initialize)
  :bind
  ("M-x" . smex)
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

;; moveline
(use-package move-text
  :ensure t
  :config)

(global-set-key (kbd "M-<up>") 'move-text-up)
(global-set-key (kbd "M-<down>") 'move-text-down)

;; company
(use-package company
  :ensure t
  )
(global-company-mode)

;; Shell - bash
(use-package flymake-shellcheck
  :ensure t
  )

(use-package flycheck-bashate
  :ensure t
  )

(require 'bash-completion)
(bash-completion-setup)

(use-package flymake-shell
  :ensure t
  )

(require 'flymake-shell)
(add-hook 'sh-set-shell-hook 'flymake-shell-load)

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

;; Helpers for easily building Emacs flymake checkers.
(use-package flymake-easy
  :ensure t
  :config
  )

;; Error list
(define-key flymake-mode-map (kbd "M-n") 'flymake-goto-next-error)
(define-key flymake-mode-map (kbd "M-p") 'flymake-goto-prev-error)

;; Ruby
(use-package flymake-ruby
  :ensure t
  :config
  )

(require 'robe)
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'robe-mode-hook 'ac-robe-setup)

(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;;robe
(use-package robe
  :ensure t
  :config
  )

;; Docker
(use-package dockerfile-mode
   :ensure t
   :defer t)

;; YAML
(use-package flymake-yaml
   :ensure t
   :config
   )

(use-package yaml-mode
  :ensure t
  :config
  )

;; Ansible
(use-package ansible
   :ensure t
   :config
   )

(use-package ansible-doc
   :ensure t
   :config
   )

(use-package company-ansible
  :ensure t
  :config
  )

(add-to-list 'company-backends 'company-ansible)
(add-hook 'yaml-mode-hook '(lambda () (ansible 1)))
(add-hook 'yaml-mode-hook #'ansible-doc-mode)

;; Markdown-mode
(use-package markdown-mode
  :ensure t
  :config
  )

;; Apache
(use-package apache-mode
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

;; Zoom in/out.
(global-set-key (kbd "M-+") 'text-scale-increase)
(global-set-key (kbd "M--") 'text-scale-decrease)

;; no toolbar:
(tool-bar-mode -1)

;; line numbers:
(global-display-line-numbers-mode 1)

;; scrolling:
(setq scroll-conservatively 100)

;; Whitespaces
(global-whitespace-mode 1)
(setq whitespace-display-mappings '((space-mark 32 [?·])))
(set-face-attribute 'whitespace-space nil :background nil :foreground "gray30")
(setq whitespace-style (quote (face tabs spaces trailing space-before-tab newline indentation empty space-after-tab space-mark tab-mark)))
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

;; no "bell" (audible notification):
(setq ring-bell-function 'ignore)

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
