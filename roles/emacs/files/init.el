;; SPDX-FileCopyrightText: 2019 Emil Lundmark <emil@lndmrk.se>
;; SPDX-License-Identifier: GPL-3.0-or-later

(when (< emacs-major-version 27)
  (defvar early-init-file
    (expand-file-name (locate-user-emacs-file "early-init.el")))
  (load early-init-file)
  (require 'early-init))

(eval-when-compile
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
  (require 'use-package))

(use-package vc
  :custom (vc-follow-symlinks t))

(use-package org
  :init
  (defconst my-config--org-files
    (directory-files user-emacs-directory t "\\.org$"))
  :config
  (mapc #'org-babel-load-file my-config--org-files))
