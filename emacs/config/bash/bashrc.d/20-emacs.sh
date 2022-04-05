# SPDX-FileCopyrightText: 2022 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

# Workaround to support 24-bit true color before Emacs 28.1.
if [[ "${COLORTERM}" == truecolor ]]; then
  alias emacs='TERM=xterm-direct emacs'
  alias emacsclient='TERM=xterm-direct emacsclient'
fi
