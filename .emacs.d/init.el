(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-collection-setup-minibuffer nil)
 '(package-selected-packages
   (quote
    (markdown-mode evil-vimish-fold yaml-mode jinja2-mode sqlup-mode sql-indent elpy color-theme-solarized evil-collection evil use-package helm))))
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

;;;;;;;;;;;;;;;;;;
;; packages
;;;;;;;;;;;;;;;;;;

;; use-package (20180314.1143)
;; more readable package configuration
(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; evil-mode (https://github.com/emacs-evil/evil)
;; vim bindings in emacs
(add-to-list 'load-path "~/.emacs.d/evil")
(use-package evil
	:init
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

;;;;;;;;;;;;;;;;;;;;;;;;;
;; display config
;;;;;;;;;;;;;;;;;;;;;;;;;

;; solarized-dark (https://github.com/sellout/emacs-color-theme-solarized)
(load-theme 'solarized t)
