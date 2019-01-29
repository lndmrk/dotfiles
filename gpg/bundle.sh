setup_gpg_debian() {
    sudo apt-get install --yes dirmngr gnupg2 scdaemon
}

setup_gpg_fedora() {
    sudo dnf install --assumeyes gnupg2 pcsc-lite

    # TODO: This may not be needed starting with Fedora 29
    # https://bugzilla.redhat.com/show_bug.cgi?id=1560348
    system_dir=/usr/share/doc/gnupg2/examples/systemd-user/
    user_dir=~/.config/systemd/user/
    mkdir --parents "${user_dir}"
    cp --force "${system_dir}"/gpg-agent.{service,socket} \
       "${system_dir}"/gpg-agent-ssh.socket \
       "${user_dir}"

    # This fragment file can't be a symlink
    # https://github.com/systemd/systemd/issues/4209
    config_dir="${XDG_CONFIG_HOME:-${HOME}/.config}/systemd/"
    fragment_dir="${config_dir}/user/gpg-agent-ssh.socket.d/"
    mkdir --parents "${fragment_dir}"
    cat >"${fragment_dir}/environment.conf" <<-EOF
	[Socket]
	ExecStartPost=/usr/bin/systemctl --user set-environment SSH_AUTH_SOCK=%t/gnupg/S.gpg-agent.ssh
	EOF
}

post_setup_gpg() {
    chmod 0700 ~/.gnupg/
    chmod 0640 ~/.gnupg/sshcontrol

    systemctl --user enable gpg-agent.socket gpg-agent-ssh.socket
}

test_gpg() {
    dirmngr --version >/dev/null
    gpg2 --version >/dev/null
}

test_gpg_debian() {
    /usr/lib/gnupg/scdaemon --version >/dev/null
}

test_gpg_fedora() {
    pcscd --version >/dev/null
}
