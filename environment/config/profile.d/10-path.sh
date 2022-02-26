# SPDX-FileCopyrightText: 2019 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

if [ -d "${HOME}/.local/bin" ]; then
  case "${PATH}" in
    "${HOME}/.local/bin"*)
      ;;
    *)
      export PATH="${HOME}/.local/bin:${PATH}"
      ;;
  esac
fi
