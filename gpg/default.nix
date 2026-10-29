# SPDX-FileCopyrightText: 2026 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

{ config, pkgs, ... }:
let
  ln = config.dotfiles.ln;
in
{
  home.file.".local/bin/env-ssh".source = ln ./local/bin/env-ssh;

  programs.gpg = {
    enable = true;
    settings = {
      no-greeting = true;

      no-emit-version = true;
      no-comments = true;

      keyid-format = "long";
      with-fingerprint = true;

      ask-cert-level = true;

      keyserver = "hkps://keys.openpgp.org";
      keyserver-options = [
        "no-honor-keyserver-url"
        "import-clean-sigs"
        "import-clean-uids"
        "export-clean-sigs"
        "export-clean-uids"
      ];

      personal-cipher-preferences = [
        "AES256"
        "AES192"
        "AES"
        "CAST5"
      ];
      personal-digest-preferences = [
        "SHA512"
        "SHA384"
        "SHA256"
        "SHA224"
      ];
      cert-digest-algo = "SHA512";
      default-preference-list = [
        "SHA512"
        "SHA384"
        "SHA256"
        "SHA224"
        "AES256"
        "AES192"
        "AES"
        "CAST5"
        "ZLIB"
        "BZIP2"
        "ZIP"
        "Uncompressed"
      ];
    };
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-gnome3;
    sshKeys = [ "C6AC387E52DE26A65AC58964B9C611201A1F8FF7" ];
  };
}
