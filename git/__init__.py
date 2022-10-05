# SPDX-FileCopyrightText: 2022 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later


def install_packages(**kwargs):
    return {
        "debian": ["git"],
        "fedora": ["git"],
    }
