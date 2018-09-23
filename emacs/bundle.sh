setup_emacs_debian() {
    sudo apt-get install --yes emacs pandoc
}

setup_emacs_fedora() {
    sudo dnf install --assumeyes emacs pandoc
}

test_emacs() {
    emacs --version >/dev/null
    pandoc --version >/dev/null
}
