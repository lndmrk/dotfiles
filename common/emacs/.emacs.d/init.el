;; Load these settings a.s.a.p.
(tool-bar-mode -1)
(setq initial-scratch-message nil)
(setq inhibit-startup-screen t)
(setq vc-follow-symlinks t)

;; Initialize packages
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'bind-key)

;; Tangle Elisp from Org files
(mapc #'org-babel-load-file (directory-files user-emacs-directory t "\\.org$"))
