# SPDX-FileCopyrightText: 2026 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

{ config, pkgs, ... }:
let
  ln = config.dotfiles.ln;
in
{
  home = {
    file = {
      ".dir_colors".source = ln ./dir_colors;
      ".local/bin/data-uri".source = ln ./local/bin/data-uri;
      ".profile".source = ln ./profile;
    };

    packages = with pkgs; [
      fd
      just
      ripgrep
    ];
  };

  xdg = {
    configFile = {
      "profile.d/10-dircolors.sh".source = ln ./config/profile.d/10-dircolors.sh;
      "profile.d/10-email.sh".source = ln ./config/profile.d/10-email.sh;
      "profile.d/10-less.sh".source = ln ./config/profile.d/10-less.sh;
      "profile.d/10-locale.sh".source = ln ./config/profile.d/10-locale.sh;
      "profile.d/10-path.sh".source = ln ./config/profile.d/10-path.sh;
      "profile.d/10-python.sh".source = ln ./config/profile.d/10-python.sh;
    };

    userDirs = {
      enable = true;
      createDirectories = true;
      publicShare = null;
      templates = null;
    };
  };
}
