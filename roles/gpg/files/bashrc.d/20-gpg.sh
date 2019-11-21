# SPDX-FileCopyrightText: 2019 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
