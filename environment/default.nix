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
      libnotify
      ripgrep
    ];
  };

  systemd.user.services."notify-error@" = {
    Unit.Description = "Send error desktop notification";
    Service = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.libnotify}/bin/notify-send \
          --urgency=critical \
          --icon=dialog-error-symbolic \
          "%i.service failed" \
          "Run `systemctl --user status %i.service` for details."
      '';
    };
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
