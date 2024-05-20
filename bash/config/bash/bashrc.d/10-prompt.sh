# SPDX-FileCopyrightText: 2019 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

__lndmrk_prompt_extra() {
  :
}

__lndmrk_prompt() {
  local exit_status=${?}
  local color_default=37
  local color_username="${color_default}"
  local color_username_sudo=31
  local color_hostname="${color_default}"
  if [[ -n "${SSH_TTY}" ]]; then
    color_hostname=97
  fi
  local color_status="${color_default}"
  if [[ ${exit_status} -gt 0 ]]; then
    color_status=31
  fi

  prompt() {
    local c1='\[\e['"${2}"'m\]'  # Default
    local c2='\[\e['"${3}"'m\]'  # Username
    local c3='\[\e['"${4}"'m\]'  # Hostname
    local c4='\[\e['"${5}"'m\]'  # Status

    case "${1}" in
      1)
        printf '%s' \
               "${c2}"'\u' \
               "${c1}"'@' \
               "${c3}"'\h' \
               ' ' \
               "${c1}"'\[\e[1m\]\W\[\e[22m\]' \
               "$(__lndmrk_prompt_extra)" \
               "${c4}"'\$'
        ;;
      2)
        printf '%s' "${c1}"'>'
        ;;
    esac
    printf '%s' '\[\e[0m\] '
  }

  PS1="$(prompt 1 \
                "${color_default}" \
                "${color_username}" \
                "${color_hostname}" \
                "${color_status}")"
  SUDO_PS1="$(prompt 1 \
                     "${color_default}" \
                     "${color_username_sudo}" \
                     "${color_hostname}" \
                     "${color_status}")"
  PS2="$(prompt 2 "${color_default}")"
  export PS1 SUDO_PS1 PS2

  unset prompt
}

if [[ "$(declare -p PROMPT_COMMAND 2>/dev/null)" =~ "^declare -a" ]]; then
  # shellcheck disable=2206
  PROMPT_COMMAND=(__lndmrk_prompt ${PROMPT_COMMAND[@]})
else
  # shellcheck disable=SC2128,SC2178
  PROMPT_COMMAND="__lndmrk_prompt; ${PROMPT_COMMAND}"
fi
