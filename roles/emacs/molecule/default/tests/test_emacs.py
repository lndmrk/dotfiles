# SPDX-FileCopyrightText: 2019 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

import pytest
import re


def test_emacs_installed(host):
    name = 'emacs'
    assert host.package(name).is_installed
    assert host.exists(name)
    version_info = host.check_output(f'{name} --version')
    version = int(re.search(r'^GNU Emacs (\d+)', version_info).group(1))
    assert version >= 26


@pytest.mark.parametrize('name', [
    'pandoc',
    'ShellCheck',
    'yamllint',
])
def test_emacs_companion_tool_installed(host, name):
    # It is not possible to set a conditional pytest.mark in the parameter list
    # since host is not available in that scope.
    if host.system_info.distribution != 'fedora':
        name = name.lower()
    assert host.package(name).is_installed
    assert host.exists(name.lower())


@pytest.mark.parametrize('name', [
    'config.org',
    'early-init.el',
    'init.el',
])
def test_emacs_configured(host, name):
    symlink = host.file(f'{host.user().home}/.emacs.d/{name}')
    assert symlink.is_symlink
    file = host.file(symlink.linked_to)
    assert file.is_file


@pytest.mark.parametrize('name', [
    'config.org',
    'init.el',
])
def test_emacs_dark_desktop_entry(host, name):
    desktop_entry = '.local/share/applications/emacs-dark.desktop'
    file = host.file(f'{host.user().home}/{desktop_entry}')
    assert file.is_file
