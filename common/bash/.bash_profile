if [[ -f ~/.bashrc ]]; then
  # shellcheck source=common/bash/.bashrc
  . ~/.bashrc
fi

if [[ -f ~/.profile ]]; then
  # shellcheck source=common/environment/.profile
  . ~/.profile
fi

if [[ -f ~/.profile-local ]]; then
  # shellcheck source=/dev/null
  . ~/.profile-local
fi
