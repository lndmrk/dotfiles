# SPDX-FileCopyrightText: 2026 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

{ config, pkgs, ... }:
let
  ln = config.dotfiles.ln;
in
{
  home.packages = with pkgs; [
    clang
    cmake
    libtool
    libvterm
    pandoc
    proselint
    shellcheck
    shfmt
    yamllint

    (python3.withPackages (
      python-pkgs: with python-pkgs; [
        python-lsp-black
        python-lsp-server
      ]
    ))
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
  };

  services.emacs = {
    client.enable = true;
    defaultEditor = true;
    enable = true;
    socketActivation.enable = true;
  };

  xdg.configFile = {
    "bash/bashrc.d/20-emacs.sh".source = ln ./config/bash/bashrc.d/20-emacs.sh;
    "emacs/config.org".source = ln ./config/emacs/config.org;
    "emacs/early-init.el".source = ln ./config/emacs/early-init.el;
    "emacs/init.el".source = ln ./config/emacs/init.el;
    "emacs/templates/99-default.eld".source = ln ./config/emacs/templates/99-default.eld;
  };
}
