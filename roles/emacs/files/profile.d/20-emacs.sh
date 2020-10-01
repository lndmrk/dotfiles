# SPDX-FileCopyrightText: 2019 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

export EMACS_SOCKET_NAME="default"
export EDITOR="emacsclient"
export VISUAL="${EDITOR}"

export MYPY_CACHE_DIR="${XDG_CACHE_HOME:-${HOME}/.cache}/mypy"
