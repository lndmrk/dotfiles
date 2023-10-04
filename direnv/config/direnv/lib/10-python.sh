# SPDX-FileCopyrightText: 2023 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

layout_poetry() {
  if [ -z "$(poetry env list)" ]; then
    poetry install
  fi

  # shellcheck disable=SC1091
  . "$(poetry env info --path)/bin/activate"
}
