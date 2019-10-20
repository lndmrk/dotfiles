# SPDX-FileCopyrightText: 2019 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

import pytest


def test_environment_dircolors(host):
    assert host.exists('dircolors')


@pytest.mark.parametrize('name', [
    'Desktop',
    'Documents',
    'Downloads',
    'Music',
    'Pictures',
    'Videos',
])
def test_environment_xdg_user_dir_present(host, name):
    assert host.file(f'{host.user().home}/{name}').is_directory


@pytest.mark.parametrize('name', [
    'Public',
    'Templates',
])
def test_environment_xdg_user_dir_absent(host, name):
    assert not host.file(f'{host.user().home}/{name}').exists
