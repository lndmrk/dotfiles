# SPDX-FileCopyrightText: 2026 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

{ config, lib, ... }:
let
  ln = config.dotfiles.ln;
in
{
  home.activation.loadGnomeSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if command -v dconf >/dev/null; then
      run dconf load / < ${./gnome.ini}
    fi
  '';

  xdg.dataFile."org.gnome.Ptyxis/palettes/modus.palette".source =
    ln ./local/share/org.gnome.Ptyxis/palettes/modus.palette;
}
