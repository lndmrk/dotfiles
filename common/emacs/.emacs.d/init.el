;; Load these settings a.s.a.p.
(tool-bar-mode -1)
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)

;; Initialize packages
(require 'package)
(setq package-enable-at-startup nil)
;; By default, HTTPS is not used for ELPA
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'bind-key)

;; Tangle Elisp from Org files
(setq vc-follow-symlinks t)
(mapc #'org-babel-load-file (directory-files user-emacs-directory t "\\.org$"))
