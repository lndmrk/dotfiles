# SPDX-FileCopyrightText: 2020 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

import pytest


@pytest.mark.parametrize('name', [
    'python3',
    'python3-virtualenv',
])
def test_python_installed(host, name):
    assert host.package(name).is_installed
