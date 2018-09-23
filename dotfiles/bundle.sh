setup_dotfiles_debian() {
    sudo apt-get install --yes shellcheck stow
}

setup_dotfiles_fedora() {
    sudo dnf install --assumeyes ShellCheck stow
}

test_dotfiles() {
    [[ ${BASH_VERSINFO[0]} -ge 4 ]]

    shellcheck --version >/dev/null
    stow --version >/dev/null

    while read -r file; do
        if grep --binary-files=without-match --with-filename \
                --line-number "[[:blank:]]$" "${file}"; then
            return 1
        fi

        if [[ "${file}" != *.sh \
                  && "${file}" != *bash-completion* \
                  && "$(file --brief "${file}")" != "Bourne-Again"* ]]; then
            continue
        fi
        shellcheck --shell=bash "${file}"
    done < <(find "${DOTFILES_BASE}" -type f -not -path '*/\.git/*')
}
