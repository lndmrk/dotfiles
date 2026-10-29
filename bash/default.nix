# SPDX-FileCopyrightText: 2026 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

{ config, ... }:
let
  ln = config.dotfiles.ln;
in
{
  home.file = {
    ".bash_logout".source = ln ./bash_logout;
    ".bash_profile".source = ln ./bash_profile;
    ".bashrc".source = ln ./bashrc;
  };

  xdg.configFile = {
    "bash/bashrc.d/10-aliases.sh".source = ln ./config/bash/bashrc.d/10-aliases.sh;
    "bash/bashrc.d/10-history.sh".source = ln ./config/bash/bashrc.d/10-history.sh;
    "bash/bashrc.d/10-prompt.sh".source = ln ./config/bash/bashrc.d/10-prompt.sh;
  };
}
