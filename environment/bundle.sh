pre_setup_environment() {
    file=~/.profile
    if [[ -f "${file}" && ! -L "${file}" ]]; then
        mv "${file}" "${file}.bak"
    fi
}

setup_environment_debian() {
    sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes \
         coreutils \
         python3 \
         task-desktop \
         xdg-user-dirs \

    for locale in en_US sv_SE; do
        sudo sed -i "s/^# *\\(${locale}.UTF-8\\)/\\1/" /etc/locale.gen
    done
    sudo locale-gen
}

setup_environment_fedora() {
    sudo dnf install --assumeyes \
         @workstation-product-environment \
         coreutils \
         langpacks-en \
         langpacks-sv \
         python3 \
         xdg-user-dirs
}

post_setup_environment() {
    if [[ ! -f ~/.config/user-dirs.dirs ]]; then
        xdg-user-dirs-update --force
    fi
    for dir in TEMPLATES PUBLICSHARE; do
        old_dir=$(xdg-user-dir "${dir}")
        target_dir="${HOME}/.${dir,,}"
        xdg-user-dirs-update --set "${dir}" "${target_dir}"
        new_dir=$(xdg-user-dir "${dir}")
        if [[ "${old_dir}" != "${new_dir}" ]]; then
            mv "${old_dir}" "${new_dir}"
        fi
    done
}

test_environment() {
    dircolors --version >/dev/null
    gio --version >/dev/null
    python3 --version >/dev/null
}
