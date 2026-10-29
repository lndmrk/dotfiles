# SPDX-FileCopyrightText: 2026 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

{ config, ... }:
let
  ln = config.dotfiles.ln;
in
{
  home.file.".local/bin/rustup-bootstrap".source = ln ./local/bin/rustup-bootstrap;

  programs.direnv.enable = true;

  xdg.configFile = {
    "bash/bashrc.d/20-direnv.sh".source = ln ./config/bash/bashrc.d/20-direnv.sh;
    "direnv/direnv.toml".source = ln ./config/direnv/direnv.toml;
    "direnv/lib/10-c.sh".source = ln ./config/direnv/lib/10-c.sh;
    "direnv/lib/10-python.sh".source = ln ./config/direnv/lib/10-python.sh;
    "direnv/lib/10-rust.sh".source = ln ./config/direnv/lib/10-rust.sh;
  };
}
