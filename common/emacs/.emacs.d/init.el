;; Load these settings a.s.a.p.
(setq inhibit-splash-screen t)

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

;; Tangle Elisp from Org files
(mapc #'org-babel-load-file (directory-files user-emacs-directory t "\\.org$"))
