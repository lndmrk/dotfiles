# SPDX-FileCopyrightText: 2019 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

import stat


def test_dotfiles_installed(host):
    bin = host.file(f'{host.user().home}/.local/bin/dotfiles')
    assert bin.is_symlink
    bin = host.file(bin.linked_to)
    assert bin.is_file
    assert bin.mode & stat.S_IXUSR


def test_dotfiles_run(host):
    local_path = f'{host.user().home}/.local/bin'
    bin = host.find_command('dotfiles', extrapaths=(local_path,))
    host.run_test(f'{bin} --help')
