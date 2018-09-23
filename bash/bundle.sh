pre_setup_bash() {
    for file in ~/.bash{_completion,_logout,_profile,rc}; do
        if [[ -f "${file}" && ! -L "${file}" ]]; then
            mv "${file}" "${file}.bak"
        fi
    done
}

setup_environment_debian() {
    sudo apt-get install --yes bash shellcheck
}

setup_environment_fedora() {
    sudo dnf install --assumeyes bash ShellCheck
}

test_bash() {
    bash --version >/dev/null

    shellcheck --shell=bash ./.bash* ./.config/bash-completion/completion
}
