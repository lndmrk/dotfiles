if [[ -f /etc/bashrc ]]; then
    # shellcheck disable=SC1091
    . /etc/bashrc
fi

if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    # shellcheck disable=SC1091
    . /usr/share/bash-completion/bash_completion
fi

PS1='\[\e[37m\]\u@\h \[\e[1m\]\W\[\e[0;37m\]\$\[\e[0m\] '
PS2='\[\e[37m\]>\[\e[0m\] '

alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias r='gio trash'

if [[ -f "${XDG_CONFIG_HOME}/bash/bashrc" ]]; then
    # shellcheck disable=SC1090
    . "${XDG_CONFIG_HOME}/bash/bashrc"
fi
