hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("firefox")
    hl.exec_cmd("swaync")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("wl-paste --type text --watch cliphist store") -- store text
    hl.exec_cmd("wl-paste --type image --watch cliphist store") -- store images
    hl.exec_cmd("amixer -c 1 sset 'Auto-Mute Mode' Disabled") -- don't mute external speakers
    hl.exec_cmd("hypridle")
    hl.exec_cmd("syncthingtray --wait")
end)