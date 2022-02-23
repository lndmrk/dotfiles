;; SPDX-FileCopyrightText: 2020 Emil Lundmark <emil@lndmrk.se>
;; SPDX-License-Identifier: GPL-3.0-or-later

(setq gc-cons-threshold (* 32 1024 1024))

(setq load-prefer-newer t)

(eval-when-compile
  (require 'package)
  (setq package-quickstart t)
  (when (< emacs-major-version 28)
    (add-to-list 'package-archives
                 '("nongnu" . "https://elpa.nongnu.org/nongnu/") t))
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))
