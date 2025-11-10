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

    subprocess.check_call(
        ("systemctl", "--user", "mask", "gcr-ssh-agent.socket"))

    subprocess.check_call(
        ("systemctl", "--user", "enable", "gpg-agent-ssh.socket"))
