DOTFILES_TARGET=${DOTFILES_TARGET:-${HOME}}
DOTFILES_MACHINE=${DOTFILES_MACHINE:-$(hostname --short)}
DOTFILES_BASE=$(realpath \
                    "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../../../../")

__bundle_script="bundle.sh"

_get_os() {
    (if [[ -f /etc/lsb-release ]]; then
         # shellcheck disable=SC1091
         . /etc/lsb-release && echo "${DISTRIB_ID}"
     elif [[ -f /etc/os-release ]]; then
         # shellcheck disable=SC1091
         . /etc/os-release && echo "${ID}"
     elif ! uname --kernel-name 2>/dev/null; then
         echo "unknown"
     fi) | tr "[:upper:]" "[:lower:]"
}

_get_bundle_namespace() {
    echo "${1//[^[:alnum:]]/_}"
}

_get_bundle_script() {
    echo "${DOTFILES_BASE}/${1}/${__bundle_script}"
}

_validate_bundle() {
    local bundle
    bundle="${1%/}"

    if [[ ! -f $(_get_bundle_script "${1}") ]]; then
        dotfiles::log error "Not a valid bundle: ${bundle}"
        return 1
    fi
    echo "${bundle}"
}

_enumerate_hooks() {
    local bundle prefix
    bundle=$(_get_bundle_namespace "${1}")
    prefix=${2}
    echo "${prefix}_${bundle}"{,_"$(_get_os)",_"${DOTFILES_MACHINE}"}
}

_call_hook() (
    set -e

    bundle=${1}
    prefix=${2}

    # shellcheck disable=SC1090
    . "$(_get_bundle_script "${bundle}")"
    for hook in $(_enumerate_hooks "${bundle}" "${prefix}"); do
        if [[ $(type -t "${hook}") == "function" ]]; then
            ${hook}
        fi
    done
)

_stow_bundle() (
    set -e

    bundle_dir="$(dotfiles::get_bundle_dir "${1}")"
    shift

    cd "${bundle_dir}/.."
    stow --no-folding --ignore=${__bundle_script} \
         --target="${DOTFILES_TARGET}" "${@}" "$(basename "${bundle_dir}")/"
)

_on_test_error() {
    local cmd func message
    cmd="${BASH_COMMAND}"
    func="${FUNCNAME[1]}"
    if [[ "${func}" == test* ]]; then
        message="${BASH_SOURCE[1]}: line ${BASH_LINENO[0]}: "
        message+="function ${func} failed"
        dotfiles::log error "${message}"
        echo "${cmd}" >&2
    fi
}

dotfiles::log() {
    local esc_end esc_start level message
    level="${1}"
    message="${2}"
    esc_start=""
    esc_end=""

    if [[ -t 1 ]]; then
        esc_start=$(
            case "${level}" in
                ok) echo -e "\\e[32m" ;;
                info) echo -e "\\e[34m" ;;
                warn) echo -e "\\e[33m" ;;
                error) echo -e "\\e[31m" ;;
            esac)
        esc_end="\\e[0m"
    fi
    echo -e "${esc_start}${level^^}: ${message}${esc_end}" >&2
}

dotfiles::get_git_repositories() {
    find "${DOTFILES_BASE}" -type d -name .git -prune
}

dotfiles::sync() {
    local error git_cmd repo
    error=0

    while read -r repo; do
        dotfiles::log info "Syncing '${repo}'"
        git_cmd=(git --git-dir "${repo}" --work-tree "${repo}/..")
        branch=$("${git_cmd[@]}" symbolic-ref --short --quiet HEAD)
        if [[ ${branch} != master ]]; then
            dotfiles::log warn "Branch is '${branch}', skipping"
            ((error+=1))
            continue
        fi
        if ! "${git_cmd[@]}" pull; then
            dotfiles::log error "Error while pulling repository"
            ((error+=1))
        fi
    done < <(dotfiles::get_git_repositories)

    if [[ ${error} -ne 0 ]]; then
        dotfiles::log error "Sync unsuccessful"
        return 1
    fi
    dotfiles::log ok "Sync completed"
}

dotfiles::get_bundles() {
    local bundle
    while read -r bundle; do
        dirname "${bundle/#${DOTFILES_BASE}\//}"
    done < <(find "${DOTFILES_BASE}/" -type f -name "${__bundle_script}" \
                  -printf '%d\t%P\n' \
                 | sort --numeric-sort --key=1 | cut --fields=2-)
}

dotfiles::get_bundle_dir() {
    local bundle
    bundle=$(_validate_bundle "${1}") || return 1
    realpath "$(dirname "$(_get_bundle_script "${bundle}")")"
}

dotfiles::enable_bundle() {
    local bundle
    bundle=$(_validate_bundle "${1}") || return 1

    dotfiles::log info "Enabling '${bundle}'"
    _call_hook "${bundle}" pre_setup
    _call_hook "${bundle}" setup
    _stow_bundle "${bundle}" --restow
    _call_hook "${bundle}" post_setup
}

dotfiles::disable_bundle() {
    local bundle
    bundle=$(_validate_bundle "${1}") || return 1

    dotfiles::log info "Disabling '${bundle}'"
    _stow_bundle "${bundle}" --delete
}

dotfiles::test_bundle() {
    local bundle
    bundle=$(_validate_bundle "${1}") || return 1

    dotfiles::log info "Testing '${bundle}'"
    set -E
    trap _on_test_error ERR
    _call_hook "${bundle}" test
}
