# SPDX-FileCopyrightText: {% now 'local', '%Y' %} {{ cookiecutter.full_name }} <{{ cookiecutter.email }}>
# SPDX-License-Identifier: GPL-3.0-or-later


def test_{{ cookiecutter.role | replace('-', '_') }}(host):
    assert False
