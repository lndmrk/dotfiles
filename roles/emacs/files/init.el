;; SPDX-FileCopyrightText: 2019 Emil Lundmark <emil@lndmrk.se>
;; SPDX-License-Identifier: GPL-3.0-or-later

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(use-package vc
  :custom (vc-follow-symlinks t))

(use-package org
  :init
  (defconst my-config--org-files
    (directory-files user-emacs-directory t "\\.org$"))
  :config
  (mapc #'org-babel-load-file my-config--org-files))
