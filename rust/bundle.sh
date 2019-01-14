setup_rust() {
    if ! rustup --version >/dev/null 2>/dev/null; then
        curl --silent --show-error --fail https://sh.rustup.rs \
            | sh -s -- -y --no-modify-path
        # shellcheck disable=SC1090
        . "${HOME}/.cargo/env"
    fi

    rustup component add \
           clippy \
           rls \
           rust-analysis \
           rust-src \
           rustfmt
}

test_rust() {
    cargo --version >/dev/null
    rustc --version >/dev/null
    rustdoc --version >/dev/null

    cargo clippy --version >/dev/null
    rls --version >/dev/null
    rustfmt --version >/dev/null
}
