# SPDX-FileCopyrightText: 2026 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

{ config, lib, ... }:
{
  options.dotfiles = {
    live = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    path = lib.mkOption {
      type = lib.types.path;
      default = /. + "${config.home.homeDirectory}/Projects/dotfiles";
    };

    ln = lib.mkOption {
      type = lib.types.functionTo lib.types.path;
      readOnly = true;
      default =
        path:
        let
          relativePath = lib.removePrefix (toString ./.) (toString path);
        in
        if config.dotfiles.live then
          config.lib.file.mkOutOfStoreSymlink (config.dotfiles.path + relativePath)
        else
          path;
    };
  };
}
