# SPDX-FileCopyrightText: 2022 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

import subprocess


def install_packages(**kwargs):
    return {
        "debian": ["gnupg", "scdaemon"],
        "fedora": ["gnupg", "pcsc-lite"],
    }


def post_setup(**kwargs):
    home_dir = kwargs["target_directory"]

    home_dir.joinpath(".gnupg").chmod(0o0700)

    autostart_file = home_dir.joinpath(".config", "autostart",
                                       "gnome-keyring-ssh.desktop")
    autostart_file.parent.mkdir(parents=True, exist_ok=True)
    autostart_file.write_text("[Desktop Entry]\n"
                              "Type=Application\n"
                              "Hidden=true\n")

    subprocess.check_call(
        ("systemctl", "--user", "enable", "gpg-agent-ssh.socket"))
