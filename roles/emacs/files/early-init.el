;; SPDX-FileCopyrightText: 2020 Emil Lundmark <emil@lndmrk.se>
;; SPDX-License-Identifier: GPL-3.0-or-later

(setq gc-cons-threshold (* 32 1024 1024))

(setq load-prefer-newer t)

(eval-when-compile
  (require 'package)
  (setq package-quickstart t)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t))

(when (< emacs-major-version 27)
  (setq package-enable-at-startup nil)
  (package-initialize)
  (provide 'early-init))
