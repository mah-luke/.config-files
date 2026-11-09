hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 1,
        col = {
            active_border = "rgba(606060ff)",
            inactive_border = "rgba(000000ff)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "master",
    },

    decoration = {
        active_opacity = 1.0,
        inactive_opacity = 1.0,
    },

    animations = {
        enabled = false,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
        mfact = 0.75,
        orientation = "center",
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        background_color = "rgba(000000ff)",
        -- 0 = off globally; DP-1 overrides with vrr = true
        vrr = 0,
    },

    input = {
        kb_layout = "us(altgr-intl)",
        kb_options = "caps:escape",
        repeat_rate = 50,
        repeat_delay = 200,
        follow_mouse = 1,
        sensitivity = 0.3,
        accel_profile = "flat",

        touchpad = {
            natural_scroll = false,
        },

        tablet = {
            output = "current",
        },
    },
})

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })