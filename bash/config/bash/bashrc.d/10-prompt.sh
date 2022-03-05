# SPDX-FileCopyrightText: 2019 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

prompt() {
  local c1='\[\e['"${2}"'m\]'  # Default
  local c2='\[\e['"${3}"'m\]'  # Username
  local c3='\[\e['"${4}"'m\]'  # Hostname
  case "${1}" in
    1)
      printf '%s' \
              "${c2}"'\u' \
              "${c1}"'@' \
              "${c3}"'\h' \
              ' ' \
              "${c1}"'\[\e[1m\]\W\[\e[22m\]' \
              '\$'
      ;;
    2)
      printf '%s' "${c1}"'>'
      ;;
  esac
  printf '%s' '\[\e[0m\] '
}

color_default=37
color_username="${color_default}"
color_hostname="${color_default}"

if [[ -n "${SSH_TTY}" ]]; then
  color_hostname=97
fi

PS1="$(prompt 1 "${color_default}" "${color_username}" "${color_hostname}")"
SUDO_PS1="$(prompt 1 "${color_default}" 31 "${color_hostname}")"
PS2="$(prompt 2 "${color_default}")"
export PS1 SUDO_PS1 PS2

unset prompt color_default color_username color_hostname
