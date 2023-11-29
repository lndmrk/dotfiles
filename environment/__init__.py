# SPDX-FileCopyrightText: 2022 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

import shutil
import subprocess
from pathlib import Path


def pre_setup(**kwargs):
    f = kwargs["target_directory"].joinpath(".profile")
    if f.is_file() and not f.is_symlink():
        f.rename(f.with_suffix(".bak"))


def install_packages(**kwargs):
    return {
        "debian": [
            "coreutils",
            "fd-find",
            "libnotify-bin",
            "locales",
            "ripgrep",
            "xdg-user-dirs",
        ],
        "fedora": [
            "coreutils",
            "fd-find",
            "langpacks-en",
            "langpacks-sv",
            "libnotify",
            "ripgrep",
            "xdg-user-dirs",
        ],
    }


def post_setup(**kwargs):
    home_dir = kwargs["target_directory"]
    config_dir = home_dir.joinpath(".config")
    xdg_user_dirs = {
        "XDG_DESKTOP_DIR": "$HOME/Desktop",
        "XDG_DOCUMENTS_DIR": "$HOME/Documents",
        "XDG_DOWNLOAD_DIR": "$HOME/Downloads",
        "XDG_MUSIC_DIR": "$HOME/Music",
        "XDG_PICTURES_DIR": "$HOME/Pictures",
        "XDG_PUBLICSHARE_DIR": "$HOME/",
        "XDG_TEMPLATES_DIR": "$HOME/",
        "XDG_VIDEOS_DIR": "$HOME/Videos",
    }

    xdg_user_dirs_config = "".join(f'{key}="{value}"\n'
                                   for key, value in xdg_user_dirs.items())
    config_dir.joinpath("user-dirs.dirs").write_text(xdg_user_dirs_config)
    config_dir.joinpath("user-dirs.locale").write_text("en_US")

    for d in xdg_user_dirs.values():
        Path(d.replace("$HOME", home_dir.as_posix())).mkdir(exist_ok=True)
    for d in ("Public", "Templates"):
        d = home_dir.joinpath(d)
        if d.is_dir():
            d.rmdir()

    if kwargs["os_release_id"] == "debian":
        subprocess.check_call(("sudo", "locale-gen"))

    if fdfind := shutil.which("fdfind"):
        fdfind = Path(fdfind)
        fd = home_dir.joinpath(".local/bin/fd")
        if fd.resolve() == fdfind.resolve():
            return
        fd.parent.mkdir(parents=True, exist_ok=True)
        fd.symlink_to(fdfind)
