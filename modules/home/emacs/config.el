;; -*- lexical-binding: t; -*-
(setq inhibit-startup-message t)

(scroll-bar-mode -1) ; disable the scroll-bar
(tool-bar-mode -1) ; disable the toolbar
(tooltip-mode -1) ; disable tootips
(set-fringe-mode 10) ; give some room
(menu-bar-mode -1) ; disable the menu bar

(setq visible-bell t) ; enable the visual bell
(electric-pair-mode t) ;; Enable Parens Pairing
(delete-selection-mode 1) ;; Enable replacing selected text instead of deleting first.
(global-auto-revert-mode t)
(electric-quote-mode t)

;; Backups
;; Define the directory where backup files should be stored
(setq backup-directory-alist
      `(("." . ,(expand-file-name "backups/" user-emacs-directory))))

;; Ensure the backup directory exists
(make-directory (expand-file-name "backups/" user-emacs-directory) t)

;; Keep backup files enabled (this is the default, but explicit)
(setq make-backup-files t)

;; Ensure standard auto-save feature is active
(setq auto-save-default t)
;; Tell auto-save-mode to save the visited file directly, not #autosave# files
(setq auto-save-visited-file-name t)

(setq auto-save-timeout 20) ;; Auto-save after 20 seconds of idle time
(setq auto-save-interval 300) ;; Auto-save after 300 characters typed

(set-face-attribute 'default nil :font "JetBrainsMono" :height 100)

;; Make ESC quit prompts
;; (global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("gnu" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Keep Emacs Folder Clean
(use-package no-littering)
;; (setq auto-save-file-name-transforms
;;       `((".*" , (no-littering-expand-var-file-name "auto-save/") t)))
;; Save in the visited file instead of an auto-save file
(setq auto-save-visited-mode t) 
(setq auto-save-visited-interval 3) ;; Save file every 3 secs

;; All the Icons
(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))
(use-package treemacs-all-the-icons
  :hook (dired-mode . treemacs-icons-dired-mode))


;; Configure Ivy
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 ("C-r" . swiper-from-isearch)
	  :map ivy-minibuffer-map
	  ("TAB" . ivy-alt-done)
	  ("C-l" . ivy-alt-done)
	  ("C-j" . ivy-next-line)
	  ("C-k" . ivy-previous-line)
	  :map ivy-switch-buffer-map
	  ("C-k" . ivy-previous-line)
	  ("C-l" . ivy-done)
	  ("C-d" . ivy-switch-buffer-kill)
	  :map ivy-reverse-i-search-map
	  ("C-k" . ivy-previous-line)
	  ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

;; Doom Themes
(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t)
  :init (load-theme 'doom-dracula t))

;; Doom Modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom (doom-modeline-height 25))

;; Line Numbers
(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		vterm-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


;; Rainbow delimeters
(use-package rainbow-delimiters
  :commands (prog-mode) ;; Load only when in prog-mode
  :hook (prog-mode . rainbow-delimiters-mode))

;; Which key
(use-package which-key
  :defer 0 ;; Load Right After Startup
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.3))

;; Ivy Rich
(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))

;; Counsel
(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 ("C-x C-r" . counsel-recentf)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)))

;; Ivy Prescient
(use-package ivy-prescient
  :after counsel
  :diminish
  (ivy-prescient-enable-filtering nil)
  :config
  (prescient-persist-mode 1)
  (ivy-prescient-mode 1))

;; Helpful Emacs Helper
(use-package helpful
  :commands (helpful-callable helpful-variable helpful-key helpful-command)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; Global Key Bindings
(use-package general
  :config (general-auto-unbind-keys t))
(general-define-key
 :prefix "C-x"
 "<return>" #'goto-last-change)

;; Sudo Edit
(use-package sudo-edit
  :defer 0)
 
;; Buffer move
;; C-x <up> Move up
;; C-x <down> Move down
;; C-{ Move left
;; C-} MOve right
(use-package buffer-move
  :defer 0)
(general-define-key
 "C-{"   'buf-move-left
 "C-}"  'buf-move-right)
(general-define-key
 :prefix "C-x"
 "<up>"     'buf-move-up
 "<down>" 'buf-move-down)

;; Rainbow Mode
(use-package rainbow-mode
  :hook prog-mode)

;; Projectile
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode 1)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :custom ((projectile-completion-system 'ivy))
  :init
  (when (file-directory-p "~/Projects")
    (setq projectile-project-search-path '("~/Projects")))
  (setq projectile-switch-project-action #'projectile-dired))
(use-package counsel-projectile
  :after (counsel projectile)
  :config (counsel-projectile-mode))

;; Dashboard
(use-package dashboard
  :demand t
  :ensure t
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq	dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Is More Than a Text Editor")
  (setq dashboard-startup-banner "~/Pictures/profile/admin.png")
  (setq dashboard-center-content nil)
  (setq dashboard-items '((recents . 5)
			  (projects . 3)
			  (registers . 3)))
  ;; (dashboard-modify-heading-icons '((recents . "file-text")))
  :config
  (dashboard-setup-startup-hook))

;; Transparency
(add-to-list 'default-frame-alist '(alpha-background . 90))

;; Peep Dired
(use-package peep-dired
  :after dired
  :hook (peep-dired-hook))

;; Treemacs
(defun verence/toggle-treemacs ()
  "Toggle the Treemacs window."
  (interactive)
  (let ((treemacs-buffer (get-buffer " *Treemacs*")))
    (if treemacs-buffer
        (progn
          (select-buffer treemacs-buffer)
          (delete-window (get-buffer-window treemacs-buffer)))
      (progn
        (treemacs)))))

(use-package treemacs
  :config
  (progn
    (setq treemacs-default-visit-action 'treemacs-visit-node-close-treemacs
	  treemacs-width 25
	  treemacs-text-scale nil
	  ))
  (treemacs-resize-icons 15)
  (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))
  :bind (("C-<tab>" . verence/toggle-treemacs)))

(use-package treemacs-projectile
  :after treemacs projectile)
(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once))


;; Git Diff
(use-package git-gutter
  :hook (prog-mode . git-gutter-mode)
  :config
  (setq git-gutter:update-interval 0.02))
(use-package git-gutter-fringe
  :config
  (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom))

;; Direnv
(use-package direnv
  :config
  :hook (direnv-envrc-mode . direnv-mode))

;; LSP

;; Languages: Yaml
(use-package yaml-mode
  :hook (yaml-mode . lsp-deferred))

;; Languages: Dockerfile
(use-package dockerfile-mode
  :hook (dockerfile-mode . lsp-deferred))

;; Language: HCL
(use-package terraform-mode
  :hook (terraform-mode . lsp-deferred))

;; Tailwind
(use-package lsp-tailwindcss :after lsp-mode)

;; Languages: CSS, HTML, EsLint, JSON
(use-package json-mode
  :hook (json-mode . lsp-deferred))

;; Languages: Nix
(use-package nix-mode
  :mode "\\.nix\\'")
(with-eval-after-load 'lsp-mode
  (lsp-register-client
    (make-lsp-client :new-connection (lsp-stdio-connection "nixd")
                     :major-modes '(nix-mode)
                     :priority 0
                     :server-id 'nixd)))

;; Language: F#
(use-package fsharp-mode
  :hook (fsharp-mode . lsp-deferred))

;; Language
(add-to-list 'auto-mode-alist '("\\.csproj?\\’" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.fsproj?\\’" . nxml-mode))

;; Web Mode
(use-package web-mode)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.cshtml?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.svelte?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.razor\\'" . web-mode))
(setq web-mode-engines-alist
      '(("razor"    . "\\.cshtml\\'")
	("blade"  . "\\.blade\\.")
	("svelte" . "\\.svelte\\.")
	("razor" . "\\.razor\\'")
	))

;; LSP Mode Setup
(defun verence/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-headerline-breadcrumb-enable-diagnostics nil)
  :hook
  (lsp-mode . verence/lsp-mode-setup)
  :hook (sh-mode . lsp)
  :hook (web-mode . lsp)
  :hook (nxml-mode . lsp)
  :hook (yaml-mode . lsp) ;; YAML
  :hook (dockerfile-mode . lsp) ;; Dockerfile
  :hook (terraform-mode . lsp) ;; Terraform
  :hook (json-mode . lsp) ;; JSON
  :hook (html-mode . lsp) ;; HTML
  :hook (css-mode . lsp) ;; CSS
  :hook (csharp-mode . lsp) ;; C#
  :hook (nix-mode . lsp) ;; Nix
  :hook (fsharp-mode . lsp) ;; F#
  :hook (python-mode . lsp) ;; Python
  :hook (typescript-mode . lsp) ;; Typescript
  :hook (js-mode . lsp) ;; Javascript
  :config
  (lsp-enable-which-key-integration t))

;; Maybe enable when auto-download feature isn’t bugged
;; (use-package lsp-sonarlint
;;   :custom
;;   (lsp-sonarlint-auto-download t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode))
(use-package lsp-treemacs
  :after lsp)
(use-package lsp-ivy
  :after lsp)

(use-package company
  :after lsp-mode
  :hook (prog-mode . company-mode)
  :bind (:map company-active-map
	      ("<tab>" . company-complete-selection))
	 (:map lsp-mode-map
	       ("<tab>" . company-indent-or-complete-common))
	 :custom
	 (company-minimum-prefix-length 1)
	 (company-idle-delay 0.1))
(use-package company-box
  :hook (company-mode . company-box-mode))
 
;; Language Markdown
(use-package markdown-mode
  :hook (markdown-mode . lsp)
  :config
  (require 'lsp-marksman))

;; Language Go
(require 'lsp-mode)
(use-package go-mode
  :hook (go-mode . lsp-deferred))
(add-hook 'go-mode-hook #'lsp-deferred)
;; Set up before-save hooks to format buffer and add/delete imports.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)


;; Terminals
;; Term: I Don't Like It
(use-package term
  :commands term
  :config
  (setq explicit-shell-file-name "bash"))
(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))


;; E-Shell
(use-package eshell-syntax-highlighting
  :after eshell-mode
  :custom
  (eshell-syntax-hightlighting-global-mode 1))

(defun verence/configure-eshell ()
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for perfomance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  (setq eshell-history-size 10000
	eshell-buffer-maximum-lines 10000
	eshell-hist-ignoredups t
	eshell-scroll-to-bottom-on-input t))
(use-package eshell-git-prompt)
(use-package eshell
  :hook (eshell-first-time-mode . verence/configure-eshell)
  :config
  (with-eval-after-load 'esh-opt
    (setq eshell-desctroy-buffer-when-process-dies t
	  eshell-visual-commands '("bash" "htop" "ssh" "top" "zsh")))
  (eshell-git-prompt-use-theme 'powerline))

;; VTerm
(use-package vterm
  :commands vterm
  :config
  ;; (setq vterm-shell "zsh")
  (setq vterm-max-scrollback 10000))

(general-define-key "C-`" 'vterm)

;; Dired
(use-package dired
  :commands (dired dired-jump)
  :ensure nil
  :bind (:map dired-mode-map ("N" . dired-create-empty-file))
  :custom  ((dired-listing-switches "-agho --group-directories-first")
	    (delete-by-moving-to-trash t)
	    (dired-dwim-target t)))
;; (use-package dired-single) : TODO: Add later

(use-package dired-open
  :after dired
  :config
  (setq dired-open-extensions '(("mkv" . "mpv"))))
(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode))
