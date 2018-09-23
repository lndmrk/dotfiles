setup_gpg_debian() {
    sudo apt-get install --yes dirmngr gnupg2
}

setup_gpg_fedora() {
    sudo dnf install --assumeyes gnupg2
}

post_setup_gpg() {
    chmod 0700 ~/.gnupg/
}

test_gpg() {
    dirmngr --version >/dev/null
    gpg2 --version >/dev/null
}
