# SPDX-FileCopyrightText: 2022 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later


def packages(**kwargs):
    return {
        "debian": ["python3-gi"],
        "fedora": ["python3-gobject"],
    }


def post_setup(**kwargs):
    from gi.repository import Gio, GLib

    # Custom key bindings
    bindings = [{
        "name": "Terminal",
        "binding": "<Super>Return",
        "command": "gnome-terminal",
    }, {
        "name": "Browser",
        "binding": "<Super>b",
        "command": "xdg-open https://",
    }]
    paths = []
    for i, binding in enumerate(bindings):
        path = ("/org/gnome/settings-daemon/plugins/media-keys"
                f"/custom-keybindings/custom{i}/")
        s = Gio.Settings.new_with_path(
            "org.gnome.settings-daemon.plugins.media-keys.custom-keybinding",
            path)
        for key, value in binding.items():
            s.set_string(key, value)
        paths.append(path)
    s = Gio.Settings.new("org.gnome.settings-daemon.plugins.media-keys")
    s.set_strv("custom-keybindings", paths)

    # Terminal
    s = Gio.Settings.new("org.gnome.Terminal.ProfilesList")
    default_profile = s.get_string("default")
    s = Gio.Settings.new_with_path(
        "org.gnome.Terminal.Legacy.Profile",
        f"/org/gnome/terminal/legacy/profiles:/:{default_profile}/")
    s.set_string("visible-name", "Modus Vivendi")
    s.set_boolean("bold-color-same-as-fg", True)
    s.set_boolean("bold-is-bright", False)
    s.set_boolean("use-theme-colors", False)
    s.set_string("background-color", "#1C1C1C")
    s.set_string("foreground-color", "#FFFFFF")
    s.set_strv("palette", [
        "#000000", "#FF8059", "#44BC44", "#EECC00", "#2FAFFF", "#FEACD0",
        "#00D3D0", "#A6A6A6", "#595959", "#F4923B", "#70C900", "#CFDF30",
        "#79A8FF", "#F78FE7", "#4AE8FC", "#FFFFFF"
    ])

    s = Gio.Settings.new("org.gnome.desktop.calendar")
    s.set_boolean("show-weekdate", True)

    s = Gio.Settings.new("org.gnome.desktop.datetime")
    s.set_boolean("automatic-timezone", True)

    s = Gio.Settings.new("org.gnome.desktop.input-sources")
    s.set_value("sources", GLib.Variant("a(ss)", [("xkb", "us"),
                                                  ("xkb", "se")]))

    s = Gio.Settings.new("org.gnome.desktop.interface")
    s.set_boolean("clock-show-date", True)
    s.set_boolean("gtk-enable-primary-paste", False)

    s = Gio.Settings.new("org.gnome.desktop.notifications")
    s.set_boolean("show-in-lock-screen", False)

    s = Gio.Settings.new("org.gnome.desktop.peripherals.touchpad")
    s.set_boolean("tap-to-click", True)

    s = Gio.Settings.new("org.gnome.desktop.wm.keybindings")
    s.set_strv("panel-run-dialog", ["<Super>F2"])
    s.set_strv("switch-applications", ["<Super>Tab"])
    s.set_strv("switch-applications-backward", ["<Shift><Super>Tab"])
    s.set_strv("switch-windows", ["<Alt>Tab"])
    s.set_strv("switch-windows-backward", ["<Shift><Alt>Tab"])

    s = Gio.Settings.new("org.gnome.desktop.wm.preferences")
    s.set_boolean("audible-bell", False)

    s = Gio.Settings.new("org.gnome.settings-daemon.plugins.color")
    s.set_boolean("night-light-enabled", True)

    s = Gio.Settings.new("org.gnome.settings-daemon.plugins.power")
    s.set_int("sleep-inactive-battery-timeout", 15 * 60)
    s.set_string("sleep-inactive-battery-type", "suspend")

    s = Gio.Settings.new("org.gnome.shell")
    s.set_strv("favorite-apps", [])

    s = Gio.Settings.new("org.gnome.mutter")
    s.set_boolean("workspaces-only-on-primary", False)

    s = Gio.Settings.new("org.gnome.system.locale")
    s.set_string("region", "sv_SE.UTF-8")

    s = Gio.Settings.new("org.gnome.system.location")
    s.set_boolean("enabled", True)
    s.set_string("max-accuracy-level", "city")

    Gio.Settings.sync()
