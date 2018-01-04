(setq inhibit-splash-screen t)

;; Place backup files in its own directory
(defconst backup-directory (concat user-emacs-directory "backups"))
(setq backup-directory-alist `((".*" . ,backup-directory)))
(setq auto-save-file-name-transforms `((".*" ,backup-directory t)))

;; Prevent Custom from modifying init.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(setq column-number-mode t)

(setq show-trailing-whitespace t)

(add-hook 'find-file-hook 'linum-mode)

(show-paren-mode t)
(setq show-paren-delay 0)

(require 'hl-line)
(global-hl-line-mode)

(add-hook 'text-mode-hook 'flyspell-mode)

(require 'package)
(setq package-enable-at-startup nil)
;; By default, HTTPS is not used for ELPA
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package fill-column-indicator
  :ensure t
  :init (setq fci-rule-column 80)
        (define-globalized-minor-mode global-fci-mode
                                      fci-mode (lambda () (fci-mode)))
  :config (global-fci-mode))

(use-package hl-todo
  :ensure t
  :config (global-hl-todo-mode))

(use-package magit
  :ensure t
  :config (global-magit-file-mode))

(use-package markdown-mode
  :ensure t
  :mode "\\.md\\'"
  :init (setq markdown-command "pandoc"))

(use-package tango-plus-theme
  :ensure t
  :config (load-theme 'tango-plus t))

(setq local-file (expand-file-name "local.el" user-emacs-directory))
(load local-file 'noerror)
