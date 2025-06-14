# SPDX-FileCopyrightText: 2022 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later


def install_packages(**kwargs):
    return {
        "debian": ["python3-gi"],
        "fedora": [
            "gnome-shell",
            "gnome-terminal",
            "gnome-themes-extra",
            "python3-gobject",
        ],
    }


def post_setup(**kwargs):
    from gi.repository import Gio, GLib

    s = Gio.Settings.new("org.freedesktop.ibus.panel.emoji")
    s.set_strv("hotkey", ["<Super>period"])

    # Custom key bindings
    bindings = [{
        "name": "Terminal",
        "binding": "<Super>Return",
        "command": "gnome-terminal",
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
    # Launchers
    s.set_strv("calculator", ["<Super>c"])
    s.set_strv("home", ["<Super>d"])
    s.set_strv("logout", ["<Super>Delete"])
    s.set_strv("screenreader", [])
    s.set_strv("www", ["<Super>b"])

    # Terminal
    s = Gio.Settings.new("org.gnome.Terminal.Legacy.Settings")
    s.set_string("theme-variant", "dark")
    s = Gio.Settings.new("org.gnome.Terminal.ProfilesList")
    default_profile = s.get_string("default")
    s = Gio.Settings.new_with_path(
        "org.gnome.Terminal.Legacy.Profile",
        f"/org/gnome/terminal/legacy/profiles:/:{default_profile}/")
    s.set_string("visible-name", "Modus Vivendi")
    s.set_boolean("audible-bell", False)
    s.set_boolean("bold-color-same-as-fg", True)
    s.set_boolean("bold-is-bright", False)
    s.set_boolean("use-theme-colors", False)
    s.set_string("background-color", "#171717")  # bg-main
    s.set_string("foreground-color", "#FFFFFF")  # fg-main
    s.set_strv("palette", [
        "#171717",  # bg-main
        "#FF5F59",  # red
        "#44BC44",  # green
        "#D0BC00",  # yellow
        "#2FAFFF",  # blue
        "#FEACD0",  # magenta
        "#00D3D0",  # cyan
        "#989898",  # fg-dim
        "#5D5D5D",  # bg-active
        "#FF5F5F",  # red-intense
        "#44DF44",  # green-intense
        "#EFEF00",  # yellow-intense
        "#338FFF",  # blue-intense
        "#FF66FF",  # magenta-intense
        "#00EFF0",  # cyan-intense
        "#FFFFFF",  # fg-main
    ])
    s.set_int("scrollback-lines", 100000)

    s = Gio.Settings.new("org.gnome.desktop.calendar")
    s.set_boolean("show-weekdate", True)

    s = Gio.Settings.new("org.gnome.desktop.datetime")
    s.set_boolean("automatic-timezone", True)

    s = Gio.Settings.new("org.gnome.desktop.input-sources")
    s.set_value("sources", GLib.Variant("a(ss)", [("xkb", "us"),
                                                  ("xkb", "se")]))
    s.set_strv("xkb-options", ["compose:ralt"])

    s = Gio.Settings.new("org.gnome.desktop.interface")
    s.set_boolean("clock-show-date", True)
    s.set_boolean("gtk-enable-primary-paste", False)
    s.set_string("gtk-theme", "Adwaita-dark")

    s = Gio.Settings.new("org.gnome.desktop.notifications")
    s.set_boolean("show-in-lock-screen", False)

    s = Gio.Settings.new("org.gnome.desktop.peripherals.touchpad")
    s.set_boolean("tap-to-click", True)

    s = Gio.Settings.new("org.gnome.desktop.wm.keybindings")
    s.set_strv("switch-to-workspace-1", ["<Super>Home"])
    s.set_strv("switch-to-workspace-left", ["<Super><Control>Left"])
    s.set_strv("switch-to-workspace-right", ["<Super><Control>Right"])
    s.set_strv("switch-to-workspace-up", ["<Super><Control>Up"])
    s.set_strv("switch-to-workspace-down", ["<Super><Control>Down"])
    s.set_strv("switch-to-workspace-last", ["<Super>End"])
    s.set_strv("switch-group", ["<Super>Above_Tab"])
    s.set_strv("switch-group-backward", ["<Shift><Super>Above_Tab"])
    s.set_strv("switch-applications", ["<Super><Control>Tab"])
    s.set_strv("switch-applications-backward", ["<Shift><Super><Control>Tab"])
    s.set_strv("switch-windows", ["<Super>Tab"])
    s.set_strv("switch-windows-backward", ["<Shift><Super>Tab"])
    s.set_strv("switch-panels", ["<Super><Control>Above_Tab"])
    s.set_strv("switch-panels-backward", ["<Shift><Super><Control>Above_Tab"])
    s.set_strv("cycle-group", ["<Super>F6"])
    s.set_strv("cycle-group-backward", ["<Shift><Super>F6"])
    s.set_strv("cycle-windows", ["<Super>Escape"])
    s.set_strv("cycle-windows-backward", ["<Shift><Super>Escape"])
    s.set_strv("cycle-panels", [])
    s.set_strv("cycle-panels-backward", [])
    s.set_strv("panel-run-dialog", ["<Super>x"])
    s.set_strv("activate-window-menu", [])
    s.set_strv("toggle-maximized", [])
    s.set_strv("maximize", ["<Super>Up"])
    s.set_strv("unmaximize", ["<Super>Down"])
    s.set_strv("minimize", [])
    s.set_strv("close", ["<Super>F4"])
    s.set_strv("begin-move", [])
    s.set_strv("begin-resize", [])
    s.set_strv("move-to-workspace-1", ["<Super><Control><Shift>Home"])
    s.set_strv("move-to-workspace-last", ["<Super><Control><Shift>End"])
    s.set_strv("move-to-workspace-left", ["<Super><Control><Shift>Left"])
    s.set_strv("move-to-workspace-right", ["<Super><Control><Shift>Right"])
    s.set_strv("move-to-workspace-up", ["<Super><Control><Shift>Up"])
    s.set_strv("move-to-workspace-down", ["<Super><Control><Shift>Down"])
    s.set_strv("move-to-monitor-left", ["<Super><Shift>Left"])
    s.set_strv("move-to-monitor-right", ["<Super><Shift>Right"])
    s.set_strv("move-to-monitor-up", ["<Super><Shift>Up"])
    s.set_strv("move-to-monitor-down", ["<Super><Shift>Down"])
    s.set_strv("switch-input-source", ["<Super>space", "XF86Keyboard"])
    s.set_strv("switch-input-source-backward",
               ["<Shift><Super>space", "<Shift>XF86Keyboard"])

    s = Gio.Settings.new("org.gnome.desktop.wm.preferences")
    s.set_boolean("audible-bell", False)

    s = Gio.Settings.new("org.gnome.settings-daemon.plugins.color")
    s.set_boolean("night-light-enabled", True)

    s = Gio.Settings.new("org.gnome.settings-daemon.plugins.power")
    s.set_int("sleep-inactive-battery-timeout", 15 * 60)
    s.set_string("sleep-inactive-battery-type", "suspend")

    s = Gio.Settings.new("org.gnome.shell")
    s.set_strv("favorite-apps", [])

    s = Gio.Settings.new("org.gnome.shell.app-switcher")
    s.set_boolean("current-workspace-only", True)

    s = Gio.Settings.new("org.gnome.shell.keybindings")
    s.set_strv("show-screen-recording-ui", [])

    s = Gio.Settings.new("org.gnome.mutter")
    s.set_boolean("workspaces-only-on-primary", False)

    s = Gio.Settings.new("org.gnome.system.locale")
    s.set_string("region", "sv_SE.UTF-8")

    s = Gio.Settings.new("org.gnome.system.location")
    s.set_boolean("enabled", True)
    s.set_string("max-accuracy-level", "city")

    Gio.Settings.sync()
