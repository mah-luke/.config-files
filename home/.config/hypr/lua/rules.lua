-- Per-monitor master layout orientation
hl.workspace_rule({ workspace = "m[desc:Microstep Optix MAG27CQ 0000000000001]", layout_opts = { orientation = "right" } })
hl.workspace_rule({ workspace = "m[desc:HP Inc. HP E24 G4 CN41450LKG]", layout_opts = { orientation = "top" } })

-- Fix some dragging issues with XWayland (from the default example config)
hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})