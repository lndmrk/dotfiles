setup_gnome_debian() {
    sudo apt-get install --yes task-gnome-desktop
    sudo systemctl set-default graphical.target
}

setup_gnome_fedora() {
    sudo dnf install --assumeyes @gnome-desktop
    sudo systemctl enable gdm.service
    sudo systemctl set-default graphical.target
}

_gnome_bind_key() {
    local schema path
    schema=org.gnome.settings-daemon.plugins.media-keys
    path=/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom
    path="${path}${1}/"

    local paths separator
    paths=$(gsettings get "${schema}" custom-keybindings)
    [[ "${paths}" = *"[]"* ]] && separator="" || separator=" ,"
    paths="${paths:0:-1}${separator}'${path}'${paths: -1}"
    gsettings set "${schema}" custom-keybindings "${paths}"

    local full
    full="${schema}.custom-keybinding:${path}"
    gsettings set "${full}" name "${2}"
    gsettings set "${full}" command "${3}"
    gsettings set "${full}" binding "${4}"
}

_gnome_terminal() {
    local profile_uuid schema path
    profile_uuid=$(gsettings get org.gnome.Terminal.ProfilesList default \
                       | tr --delete "'")
    schema=org.gnome.Terminal.Legacy.Profile
    path="/org/gnome/terminal/legacy/profiles:/:${profile_uuid}/"
    gsettings set "${schema}:${path}" "${@}"
}

post_setup_gnome() {
    # Reset everyting to default
    for schema in $(gsettings list-schemas); do
        gsettings reset-recursively "${schema}"
    done

    # Key bindings
    _gnome_bind_key 0 Terminal gnome-terminal "<Super>Return"
    _gnome_bind_key 1 Browser "xdg-open https://" "<Super>b"

    # Terminal
    _gnome_terminal use-theme-colors false
    _gnome_terminal foreground-color 'rgb(204,204,204)'
    _gnome_terminal background-color 'rgb(45,45,45)'
    palette_tomorrow_night_eighties="[\
    'rgb(3,2,2)', 'rgb(172,40,43)', \
    'rgb(63,143,63)', 'rgb(193,138,28)', \
    'rgb(41,100,157)', 'rgb(141,63,141)', \
    'rgb(36,147,147)', 'rgb(153,152,152)', \
    'rgb(102,102,102)', 'rgb(242,119,122)', \
    'rgb(153,204,153)', 'rgb(255,204,102)', \
    'rgb(102,153,204)', 'rgb(204,153,204)', \
    'rgb(102,204,204)', 'rgb(204,204,204)' \
    ]"
    _gnome_terminal palette "${palette_tomorrow_night_eighties}"
    _gnome_terminal scrollback-unlimited true

    # Misc
    set +e

    gsettings set org.gnome.desktop.calendar show-weekdate true

    gsettings set org.gnome.desktop.datetime automatic-timezone true

    gsettings set org.gnome.desktop.input-sources sources \
              "[('xkb', 'us'), ('xkb', 'se')]"

    gsettings set org.gnome.desktop.interface clock-show-date true
    gsettings set org.gnome.desktop.interface gtk-enable-primary-paste false

    gsettings set org.gnome.desktop.notifications show-in-lock-screen false

    gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true

    gsettings set org.gnome.desktop.wm.keybindings \
              panel-run-dialog "['<Super>F2']"
    gsettings set org.gnome.desktop.wm.preferences audible-bell false

    gsettings set org.gnome.settings-daemon.plugins.color \
              night-light-enabled true

    gsettings set org.gnome.settings-daemon.plugins.power \
              sleep-inactive-battery-timeout 900
    gsettings set org.gnome.settings-daemon.plugins.power \
              sleep-inactive-battery-type 'suspend'

    gsettings set org.gnome.shell favorite-apps "[]"
    gsettings set org.gnome.shell.overrides workspaces-only-on-primary false

    gsettings set org.gnome.system.locale region 'sv_SE.UTF-8'

    gsettings set org.gnome.system.location enabled true
    gsettings set org.gnome.system.location max-accuracy-level 'city'

    set -e
}

test_gnome() {
    gnome-help --version >/dev/null

    [[ $(systemctl get-default) == "graphical.target" ]]
}
