;; SPDX-FileCopyrightText: 2019 Emil Lundmark <emil@lndmrk.se>
;; SPDX-License-Identifier: GPL-3.0-or-later

(eval-when-compile
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
  (require 'use-package))

(use-package vc
  :custom (vc-follow-symlinks t))

(use-package org
  :ensure t
  :init
  (defconst my-config--org-files
    (directory-files user-emacs-directory t "\\.org$"))
  :config
  (mapc #'org-babel-load-file my-config--org-files))
