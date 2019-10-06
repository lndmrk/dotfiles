# SPDX-FileCopyrightText: 2019 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

import pytest
import re


def test_gpg_installed(host):
    name = 'gpg'
    assert host.exists(name)
    version_info = host.check_output(f'{name} --version')
    version = int(re.search(r'^gpg \(GnuPG\) (\d+)', version_info).group(1))
    assert version >= 2


def test_gpg_config_directory_permissions(host):
    assert host.file(f'{host.user().home}/.gnupg/').mode == 0o0700


@pytest.mark.parametrize('name', [
    'gpg-agent.conf',
    'gpg.conf',
    'sshcontrol',
])
def test_gpg_configured(host, name):
    symlink = host.file(f'{host.user().home}/.gnupg/{name}')
    assert symlink.is_symlink
    file = host.file(symlink.linked_to)
    assert file.is_file
