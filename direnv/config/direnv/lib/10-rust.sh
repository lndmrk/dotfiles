# SPDX-FileCopyrightText: 2023 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

layout_rustup() {
  # shellcheck disable=SC1091
  . "${HOME}/.cargo/env"
}

layout_rust() {
  layout rustup

  rustup toolchain install stable
  rustup component add \
         cargo \
         clippy \
         rust-analyzer \
         rust-docs \
         rust-std \
         rustc \
         rust-src \
         rustfmt

  rustup toolchain install nightly
  rustup +nightly component add \
         miri
}
