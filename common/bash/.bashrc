if [[ -f /etc/bashrc ]]; then
    # shellcheck disable=SC1091
    . /etc/bashrc
fi

PS1='\[\e[37m\]\u@\h \[\e[1m\]\W\[\e[0;37m\]\$\[\e[0m\] '
PS2='\[\e[37m\]>\[\e[0m\] '

alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias r='gio trash'

if [[ -f ~/.local/etc/bash/bashrc ]]; then
    # shellcheck disable=SC1090
    . ~/.local/etc/bash/bashrc
fi
