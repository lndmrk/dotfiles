# SPDX-FileCopyrightText: 2019 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

if systemctl --user >/dev/null 2>&1; then
  export EMACS_SOCKET_NAME="default"
  export EDITOR="emacsclient"
else
  export EDITOR="emacs"
fi
export VISUAL="${EDITOR}"
