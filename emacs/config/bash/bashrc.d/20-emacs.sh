# SPDX-FileCopyrightText: 2022 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

# Workaround to support 24-bit true color before Emacs 28.1.
if [[ "${COLORTERM}" == truecolor ]]; then
  alias emacs='TERM=xterm-direct emacs'
  alias emacsclient='TERM=xterm-direct emacsclient'
fi

if [[ "${INSIDE_EMACS}" == vterm ]]; then
  __vterm_printf(){
    printf "\e]%s\e\\" "${1}"
  }

  __vterm_prompt(){
    PS1="${PS1}$(__vterm_printf "51;A$(whoami)@$(hostname):$(pwd)")"
  }

  if [[ "$(declare -p PROMPT_COMMAND 2>/dev/null)" =~ "^declare -a" ]]; then
    # shellcheck disable=2206
    PROMPT_COMMAND=(${PROMPT_COMMAND[@]} __vterm_prompt)
  else
    # shellcheck disable=SC2128,SC2178
    PROMPT_COMMAND="${PROMPT_COMMAND}; __vterm_prompt"
  fi
fi
