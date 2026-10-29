# SPDX-FileCopyrightText: 2026 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

{ config, ... }:
let
  ln = config.dotfiles.ln;
in
{
  home.file.".local/bin/git-gh-fork".source = ln ./local/bin/git-gh-fork;

  programs.git.enable = true;

  xdg.configFile = {
    "git/config".source = ln ./config/git/config;
    "git/ignore".source = ln ./config/git/ignore;
  };
}
