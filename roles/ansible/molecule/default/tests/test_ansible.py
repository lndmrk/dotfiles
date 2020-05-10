# SPDX-FileCopyrightText: 2020 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later


def test_ansible_installed(host):
    name = 'ansible'
    assert host.package(name).is_installed
    assert host.exists(name)

def test_ansible_dependencies_installed(host):
    assert host.package('python3-netaddr').is_installed
