if [[ -f /etc/bashrc ]]; then
  # shellcheck disable=SC1091
  . /etc/bashrc
fi

PS1='\[\e[37m\]\u@\h \[\e[1m\]\W\[\e[0;37m\]\$\[\e[0m\] '
PS2='\[\e[37m\]>\[\e[0m\] '

alias r='gio trash'
