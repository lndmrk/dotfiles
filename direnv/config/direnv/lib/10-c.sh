# SPDX-FileCopyrightText: 2023 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

layout_compilation_database() {
  build_dir="${1:-build}"

  if [ -f "${build_dir}/compile_commands.json" ]; then
    ln --symbolic --force "${build_dir}/compile_commands.json" .
  fi

  unset build_dir
}
