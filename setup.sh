#!/bin/bash

set -euo pipefail

pkg() {
  sudo dnf install --assumeyes "$@"
}

# misc
pkg git \
    ShellCheck \
    stow

# xdg
mv "$HOME/Public" "$HOME/.public/" || mkdir --parents "$HOME/.public"
mv "$HOME/Templates" "$HOME/.templates/" || mkdir --parents "$HOME/.templates"
