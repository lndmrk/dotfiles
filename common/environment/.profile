export LANG="en_US.UTF-8"
export LC_ALL=""
export LC_ADDRESS="sv_SE.UTF-8"
export LC_COLLATE="sv_SE.UTF-8"
export LC_CTYPE="sv_SE.UTF-8"
export LC_IDENTIFICATION="sv_SE.UTF-8"
export LC_MEASUREMENT="sv_SE.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="sv_SE.UTF-8"
export LC_NAME="sv_SE.UTF-8"
export LC_NUMERIC="sv_SE.UTF-8"
export LC_PAPER="sv_SE.UTF-8"
export LC_TELEPHONE="sv_SE.UTF-8"
export LC_TIME="sv_SE.UTF-8"

export PATH="$HOME/.local/bin:$PATH"

export PAGER="less"
export LESS="-FMR"

export VISUAL="emacs"

if [ -f ~/.local/etc/profile/profile ]; then
    # shellcheck disable=SC1090
    . ~/.local/etc/profile/profile
fi
