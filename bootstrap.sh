# shellcheck disable=SC1090
. "$(dirname "${BASH_SOURCE[0]}")/dotfiles/.local/share/dotfiles/libdotfiles.sh"

dotfiles::log info "Setting up Git hooks"
for hook in "${DOTFILES_BASE}/.hooks/"*; do
    while read -r repo; do
        ln --symbolic --force --relative "${hook}" "${repo}/hooks/"
    done < <(dotfiles::get_git_repositories)
done

dotfiles::enable_bundle dotfiles
PATH="${HOME}/.local/bin:${PATH}"
dotfiles::log ok "Bootstrap complete"
