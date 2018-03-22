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

export PATH="$PATH:$HOME/.local/bin"

export PAGER="less"
export LESS="-FMR"

export VISUAL="emacs"

export GIT_AUTHOR_NAME="Emil Lundmark"
export GIT_AUTHOR_EMAIL="emil@lndmrk.se"
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

if [ -f ~/.profile-local ]; then
  # shellcheck source=/dev/null
  . ~/.profile-local
fi
