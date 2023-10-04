# SPDX-FileCopyrightText: 2022 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

import subprocess


def pre_setup(**kwargs):
    f = kwargs["target_directory"].joinpath(".emacs")
    if f.is_file() and not f.is_symlink():
        f.rename(f.with_suffix(".bak"))
    d = kwargs["target_directory"].joinpath(".emacs.d")
    if d.is_dir() and not d.is_symlink():
        d.rename(d.with_suffix(".bak"))


def install_packages(**kwargs):
    return {
        "debian": [
            "clang",
            "clang-format",
            "clang-tidy",
            "clang-tools",
            "emacs",
            "pandoc",
            "python3",
            "python3-proselint",
            "python3-pylsp",
            "python3-pylsp-black",
            "shellcheck",
            "yamllint",
        ],
        "fedora": [
            "clang",
            "emacs",
            "pandoc",
            "proselint",
            "python3",
            "python3-lsp-black",
            "python3-lsp-server",
            "ShellCheck",
            "yamllint",
        ],
    }


def post_setup(**kwargs):
    subprocess.check_call(("systemctl", "--user", "enable", "emacs.socket"))
    subprocess.check_call(("systemctl", "--user", "daemon-reload"))
