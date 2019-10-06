# SPDX-FileCopyrightText: 2019 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

import pytest
import re


def test_git_installed(host):
    name = 'git'
    assert host.package(name).is_installed
    assert host.exists(name)
    version_info = host.check_output(f'{name} --version')
    version = int(re.search(r'^git version (\d+)', version_info).group(1))
    assert version >= 2


@pytest.mark.parametrize('name', [
    'config',
    'ignore',
])
def test_git_configured(host, name):
    symlink = host.file(f'{host.user().home}/.config/git/{name}')
    assert symlink.is_symlink
    file = host.file(symlink.linked_to)
    assert file.is_file
