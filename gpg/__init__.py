# SPDX-FileCopyrightText: 2022 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

import subprocess


def packages(**kwargs):
    return {
        "debian": ["gnupg", "scdaemon"],
        "fedora": ["gnupg", "pcsc-lite"],
    }


def post_setup(**kwargs):
    config_dir = kwargs["target_directory"].joinpath(".gnupg")
    config_dir.chmod(0o0700)

    subprocess.check_call(
        ("systemctl", "--user", "enable", "gpg-agent-ssh.socket"))
