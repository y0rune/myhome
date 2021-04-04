;Packages

;; package archives
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives
      '(
	("melpa" . "https://melpa.org/packages/")
	("ELPA"  . "http://tromey.com/elpa/")
	("gnu"   . "http://elpa.gnu.org/packages/")
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
(setq ido-enable-flex-matching t)
;;(setq ido-everywhere t)
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

(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

; Global turn on flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

; Org Files
(add-hook 'org-mode-hook '(lambda () (setq fill-column 80)))
(add-hook 'org-mode-hook 'auto-fill-mode)
(add-hook 'org-mode-hook 'turn-on-flyspell)

;; Latex files
(add-hook 'latex-mode-hook 'turn-on-flyspell)
(setq ispell-dictionary "pl")

;; Broswer
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "browser-x")

;; Custom theme
(add-to-list 'custom-theme-load-path
	     "~/.emacs.d/plugins/")

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

(setq company-dabbrev-downcase 0)
(setq company-idle-delay 0)

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

;; Default font
(defun rc/get-default-font ()
  (cond
   ((eq system-type 'windows-nt) "Consolas-13")
   ((eq system-type 'gnu/linux) "xos4 Terminus Bold 16")))

(add-to-list 'default-frame-alist `(font . ,(rc/get-default-font)))

;; Theme
;;(use-package dracula-theme
;;  :ensure t
;;  :config
;;  (load-theme 'dracula t))

(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t))



;; Sitebar dirred
(use-package dired-sidebar
  :ensure t
  :commands (dired-sidebar-toggle-sidebar))

(require 'dired-sidebar)
(global-set-key (kbd "C-x d") 'dired-sidebar-toggle-sidebar)

;; Smex
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

;;buffer-move
(require 'buffer-move)
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)

;; Multiple-cursors
(use-package multiple-cursors
    :ensure t
    :config
)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

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

;;robe
(use-package robe
  :ensure t
  :config
  )

(require 'robe)
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'robe-mode-hook 'ac-robe-setup)
(eval-after-load 'company
  '(push 'company-robe company-backends))

(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;; Docker
(use-package dockerfile-mode
   :ensure t
   :defer t)

;; YAML
(require 'flymake-yaml)

(use-package yaml-mode
  :ensure t
  :config
  )

;; pip install --user yamllint
(require 'flycheck-yamllint)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook 'flycheck-yamllint-setup))

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
(custom-set-variables
 '(markdown-command "/usr/bin/pandoc"))
(use-package markdown-mode
  :ensure t
  :config
  )

;; C++ C
(use-package auto-complete-clang
  :ensure t
  :config
  )

;; Apache
(use-package apache-mode
  :ensure t
  :config
  )

;; Haskell
(use-package haskell-mode
  :ensure t
  :config
)

(use-package flycheck-haskell
  :ensure t
  :config
  )
(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup)


;; Java
;; lsp-install-server
;; jdtls
(use-package lsp-java
  :ensure t
  :config
  (global-set-key (kbd "C-.") 'lsp-execute-code-action)
)

(global-set-key (kbd "<f9>") 'dap-breakpoint-toggle)
(global-set-key (kbd "<f10>") 'dap-next)
(global-set-key (kbd "<f11>") 'dap-step-in)
(global-set-key (kbd "<f12>") 'lsp-jt-browser)
(global-set-key (kbd "<C-f12>") 'dap-stop-thread)
(global-set-key (kbd "<C-?>") 'comment-or-uncomment-region)

(add-hook 'dap-stopped-hook
          (lambda (arg) (call-interactively #'dap-hydra)))

(setq dap-auto-configure-features '(sessions locals controls tooltip))


(require 'lsp-java)
(add-hook 'java-mode-hook #'lsp)

(require 'dap-java)

;; Treemacs
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
	  treemacs-deferred-git-apply-delay      0.5
	  treemacs-directory-name-transformer    #'identity
	  treemacs-display-in-side-window        t
	  treemacs-eldoc-display                 t
	  treemacs-file-event-delay              5000
	  treemacs-file-extension-regex          treemacs-last-period-regex-value
	  treemacs-file-follow-delay             0.2
	  treemacs-file-name-transformer         #'identity
	  treemacs-follow-after-init             t
	  treemacs-git-command-pipe              ""
	  treemacs-goto-tag-strategy             'refetch-index
	  treemacs-indentation                   2
	  treemacs-indentation-string            " "
	  treemacs-is-never-other-window         nil
	  treemacs-max-git-entries               5000
	  treemacs-missing-project-action        'ask
	  treemacs-move-forward-on-expand        nil
	  treemacs-no-png-images                 nil
	  treemacs-no-delete-other-windows       t
	  treemacs-project-follow-cleanup        nil
	  treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
	  treemacs-position                      'left
	  treemacs-read-string-input             'from-child-frame
	  treemacs-recenter-distance             0.1
	  treemacs-recenter-after-file-follow    nil
	  treemacs-recenter-after-tag-follow     nil
	  treemacs-recenter-after-project-jump   'always
	  treemacs-recenter-after-project-expand 'on-distance
	  treemacs-show-cursor                   nil
	  treemacs-show-hidden-files             t
	  treemacs-silent-filewatch              nil
	  treemacs-silent-refresh                nil
	  treemacs-sorting                       'alphabetic-asc
	  treemacs-space-between-root-nodes      t
	  treemacs-tag-follow-cleanup            t
	  treemacs-tag-follow-delay              1.5
	  treemacs-user-mode-line-format         nil
	  treemacs-user-header-line-format       nil
	  treemacs-width                         35
	  treemacs-workspace-switch-cleanup      nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (pcase (cons (not (null (executable-find "git")))
		 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
	("M-0"       . treemacs-select-window)
	("C-x t 1"   . treemacs-delete-other-windows)
	("C-x t t"   . treemacs)
	("C-x t B"   . treemacs-bookmark)
	("C-x t C-t" . treemacs-find-file)
	("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after treemacs evil
  :ensure t)

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package treemacs-icons-dired
  :after treemacs dired
  :ensure t
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after treemacs magit
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after treemacs persp-mode ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

;; Python
(use-package company-jedi
    :ensure t
    :config
)

(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/python-mode-hook)

(setq-default ebuild-mode-update-copyright nil)

(defun infer-indentation-style () (interactive)
  (let ((space-count (how-many "^  " (point-min) (point-max)))
	(tab-count (how-many "^\t" (point-min) (point-max))))
    (if (> space-count tab-count) (setq indent-tabs-mode nil))
    (if (> tab-count space-count) (setq indent-tabs-mode t))))

(add-hook 'python-mode-hook
	  (lambda ()
	    (if indent-tabs-mode
		(setq tab-width 4
		      python-indent-offset 4))))
(add-hook 'python-mode-hook 'infer-indentation-style)

;;; --- Look & Feel ---

;; Helm
(use-package helm
   :ensure t
   :config
)

(add-hook 'helm-minibuffer-set-up-hook
	  'helm-hide-minibuffer-maybe)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)

(helm-autoresize-mode 1)
(helm-mode 1)

;; Disable scroll bar
;; no toolbar:
(if (display-graphic-p)
    (progn
      (tool-bar-mode -1)
      (scroll-bar-mode -1)))

;; Copy
(setq select-active-regions nil)
(setq mouse-drag-copy-region t)
(global-set-key [mouse-2] 'mouse-yank-at-click)

;; Zoom in/out.
(global-set-key (kbd "M-+") 'text-scale-increase)
(global-set-key (kbd "M--") 'text-scale-decrease)

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
