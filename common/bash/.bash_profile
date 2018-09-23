if [[ -f ~/.bashrc ]]; then
    # shellcheck disable=SC1090
    . ~/.bashrc
fi

if [[ -f ~/.profile ]]; then
    # shellcheck disable=SC1090
    . ~/.profile
fi
