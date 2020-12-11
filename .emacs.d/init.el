(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-collection-setup-minibuffer nil)
 '(package-selected-packages
   (quote
    (protobuf-mode hydra markdown-mode evil-vimish-fold yaml-mode jinja2-mode sqlup-mode sql-indent elpy color-theme-solarized evil-collection evil use-package helm))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; M-x eval-buffer to reload this ;;

;; global variables
(setq
 inhibit-startup-screen t
 column-number-mode t
 use-package-always-ensure t)

;; use y or n whenever yes or no is required
(fset 'yes-or-no-p 'y-or-n-p)

;; buffer local variables
(setq-default
 indent-tabs-mode nil
 tab-width 4
 c-basic-offset 4)

;; modes
(electric-indent-mode 0)

;; whitespace
;;  - add newline to end of file
(setq require-final-newline t)

;;  - delete trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; package manager
(require 'package)
(setq
 package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                    ("org" . "http://orgmode.org/elpa/")
                    ("melpa" . "http://melpa.org/packages/")
                    ("melpa-stable" . "http://stable.melpa.org/packages/"))
 package-archive-priorities '(("melpa-stable" . 1)))

(setq package-enable-at-startup nil)
(package-initialize)

;; local custom elisp files (function defs, etc)
(add-to-list 'load-path "~/.emacs.d/my-custom")

;;;;;;;;;;;;;;;;;;
;; packages
;;;;;;;;;;;;;;;;;;

;; use-package (20180314.1143)
;; more readable package configuration
(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Enable defer and ensure by default for use-package
;; Keep auto-save/backup files separate from source code:  https://github.com/scalameta/metals/issues/1027
(setq use-package-always-defer t
      use-package-always-ensure t
      backup-directory-alist `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;; evil-mode (https://github.com/emacs-evil/evil)
;; vim bindings in emacs
;; (add-to-list 'load-path "~/.emacs.d/evil")
(use-package evil
	:init
    (setq evil-want-keybinding nil)
	(setq evil-want-integration nil)
	:config
	(evil-mode 1))

;; evil-collection (20180604.1813)
;; providing vimish key bindings for different modes
(use-package evil-collection
	:after evil
	:custom
	(evil-collection-setup-minibuffer)
	:config
	(evil-collection-init))

;; helm (2.9.5)
;; much improved incremental search / completion
(use-package helm
	:init
  	(require 'helm-config)
  	(helm-mode)
	(ido-mode -1)
	:bind
	("M-x" . 'helm-M-x)
	("C-x C-f" . 'helm-find-files)
	("C-h a"   . 'helm-apropos)
	("C-x r b" . 'helm-filtered-bookmarks)
	("C-x C-b" . 'helm-buffers-list))

;; elpy ()
;; emacs IDE for python
(use-package elpy
	:init
    (elpy-enable)
    :bind
    ("C-c g" . 'elpy-goto-definition))


;; sql-indent (1.2)
;; basic automatic sql indentation
(use-package sql-indent
    :ensure t
    :pin gnu
	:config

    ;; Custom rules for sql-indent
    (defvar my-sql-indentation-offsets-alist
      `( ;; put new syntactic symbols here, and add the default ones at the end.
         ;; If there is no value specified for a syntactic symbol, the default
         ;; will be picked up.
        (select-clause 0)
        (select-table-continuation +)
        ,@sqlind-default-indentation-offsets-alist))

    ;; Arrange for the new indentation offset to be set up for each SQL buffer.
    (add-hook 'sqlind-minor-mode-hook
              (lambda ()
                (setq sqlind-indentation-offsets-alist
                      my-sql-indentation-offsets-alist)))

    (add-hook 'sql-mode-hook 'sqlind-minor-mode))

;; sql-upmode ()
;; basic automatic sql upper casing
(use-package sqlup-mode
	:config
    (add-hook 'sql-mode-hook 'sqlup-mode))

;; evil-vimish-fold ()
;; use standard vim zf and zd bindings to fold / unfold
(use-package evil-vimish-fold
	:init
    (evil-vimish-fold-mode 1))

;; hydra (0.15.0)
;; use hydra package to help manage emacs key bindings
(use-package hydra
    :config
    (load "my-hydras"))

;; scala-mode ()
;; Enable scala-mode for highlighting, indentation and motion commands
(use-package scala-mode
  :interpreter
    ("scala" . scala-mode))

;; Enable sbt mode for executing sbt commands
(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
   ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
   (setq sbt:program-options '("-Dsbt.supershell=false"))
)

;; Enable nice rendering of diagnostics like compile errors.
(use-package flycheck
  :init (global-flycheck-mode))

(use-package lsp-mode
  ;; Optional - enable lsp-mode automatically in scala files
  :hook  (scala-mode . lsp)
         (lsp-mode . lsp-lens-mode)
  :config (setq lsp-prefer-flymake nil))

;; Add metals backend for lsp-mode
(use-package lsp-metals
  :config (setq lsp-metals-treeview-show-when-views-received t))

;; Enable nice rendering of documentation on hover
(use-package lsp-ui)

;; lsp-mode supports snippets, but in order for them to work you need to use yasnippet
;; If you don't want to use snippets set lsp-enable-snippet to nil in your lsp-mode settings
;;   to avoid odd behavior with snippets and indentation
(use-package yasnippet)

;; Add company-lsp backend for metals
(use-package company-lsp)

;; Use the Debug Adapter Protocol for running tests and debugging
(use-package posframe
  ;; Posframe is a pop-up tool that must be manually installed for dap-mode
  )
(use-package dap-mode
  :hook
  (lsp-mode . dap-mode)
  (lsp-mode . dap-ui-mode)
  )


;;;;;;;;;;;;;;;;;;;;;;;;;
;; display config
;;;;;;;;;;;;;;;;;;;;;;;;;

;; solarized-dark (https://github.com/sellout/emacs-color-theme-solarized)
(use-package color-theme-solarized
  :init
  (load-theme 'solarized t)
  (setq frame-background-mode 'dark)
  (set-terminal-parameter nil 'background-mode 'dark)
  (enable-theme 'solarized))
