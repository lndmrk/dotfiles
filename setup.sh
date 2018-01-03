#!/bin/bash

set -euo pipefail

get_distro() {
  (if [[ -f /etc/lsb-release ]]; then
     (. /etc/lsb-release && echo "${DISTRIB_ID}")
   elif [[ -f /etc/os-release ]]; then
     (. /etc/os-release && echo "${ID}")
   else
     uname -s
   fi) | tr '[:upper:]' '[:lower:]'
}

# shellcheck source=/dev/null
. "setup-$(get_distro).sh" || true

# xdg
mv "$HOME/Public" "$HOME/.public/" || mkdir --parents "$HOME/.public"
mv "$HOME/Templates" "$HOME/.templates/" || mkdir --parents "$HOME/.templates"
