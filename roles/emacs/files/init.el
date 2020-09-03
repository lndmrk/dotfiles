;; SPDX-FileCopyrightText: 2019 Emil Lundmark <emil@lndmrk.se>
;; SPDX-License-Identifier: GPL-3.0-or-later

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
(use-package bind-key
  :ensure t)
(use-package diminish
  :ensure t)

;; Configuration management
(defconst my-config--org-files
  (directory-files user-emacs-directory t "\\.org$"))
(mapc #'org-babel-load-file my-config--org-files)
