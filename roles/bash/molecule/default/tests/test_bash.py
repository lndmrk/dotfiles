# SPDX-FileCopyrightText: 2019 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

import pytest
import re


def test_bash_installed(host):
    name = 'bash'
    assert host.package(name).is_installed
    assert host.exists(name)
    version_info = host.check_output(f'{name} --version')
    version = int(re.search(r'^GNU bash, version (\d+)', version_info)
                  .group(1))
    assert version >= 5


def test_bash_login_removed(host):
    file = host.file(f'{host.user().home}/.bash_login')
    assert not file.exists


@pytest.mark.parametrize('name', [
    '.bash_logout',
    '.bash_profile',
    '.bashrc',
])
def test_bash_configured(host, name):
    symlink = host.file(f'{host.user().home}/{name}')
    assert symlink.is_symlink
    file = host.file(symlink.linked_to)
    assert file.is_file
