setup_rust() {
    if ! rustup; then
        curl --silent --show-error --fail https://sh.rustup.rs \
            | sh -s -- -y --no-modify-path
        # shellcheck disable=SC1090
        . "${HOME}/.cargo/env"
    fi

    if ! rustfmt; then
        rustup component add rustfmt-preview
    fi

    if ! rls; then
        rustup component add rls-preview rust-analysis rust-src
    fi
}

test_rust() {
    cargo --version >/dev/null
    rustc --version >/dev/null

    rustfmt --version >/dev/null

    rls --version >/dev/null
}
