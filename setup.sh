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
for dir in Public Templates; do
  hidden_dir="${HOME}/.${dir,,}"
  if [[ -d "${HOME}/${dir}" ]]; then
    mv "${HOME}/${dir}" "${hidden_dir}"
  else
    mkdir --parents "${hidden_dir}"
  fi
done
