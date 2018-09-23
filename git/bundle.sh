setup_git_debian() {
    sudo apt-get install --yes git
}

setup_git_fedora() {
    sudo dnf install --assumeyes git
}

test_git() {
    git --version >/dev/null
}
