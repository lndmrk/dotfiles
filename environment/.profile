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

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"

export PATH="${HOME}/.local/bin:${PATH}"

export PAGER="less"
export LESS="-FMR"

export VISUAL="emacs"

if [ -f "${XDG_CONFIG_HOME}/environment/profile" ]; then
    # shellcheck disable=SC1090
    . "${XDG_CONFIG_HOME}/environment/profile"
fi

if [ -f "${HOME}/.cargo/env" ]; then
    # shellcheck disable=SC1090
    . "${HOME}/.cargo/env"
fi
