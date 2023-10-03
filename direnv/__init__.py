# SPDX-FileCopyrightText: 2023 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later


def install_packages(**kwargs):
    return {
        "debian": ["direnv"],
        "fedora": ["direnv"],
    }
