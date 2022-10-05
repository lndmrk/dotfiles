# SPDX-FileCopyrightText: 2022 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later


def pre_setup(**kwargs):
    to_backup = [
        ".bash_login",
        ".bash_logout",
        ".bash_profile",
        ".bashrc",
    ]
    for f in to_backup:
        f = kwargs["target_directory"].joinpath(f)
        if f.is_file() and not f.is_symlink():
            f.rename(f.with_suffix(".bak"))


def install_packages(**kwargs):
    return {
        "debian": ["bash"],
        "fedora": ["bash"],
    }
