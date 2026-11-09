-- Fallback for monitors not configured below
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

-- T495s internal panel
hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "0x0", scale = 1 })

-- Ultrawide with HDR
hl.monitor({
    output = "DP-1",
    mode = "3440x1440@240",
    position = "0x0",
    scale = 1,
    bitdepth = 10,
    vrr = true,
    cm = "hdr",
    sdrbrightness = 1.3,
    sdrsaturation = 1.0,
    max_luminance = 1000,
    min_luminance = 0,
    -- max_avg_luminance = 800,
    -- sdr_max_luminance = 250,
    -- sdr_min_luminance = 0.005,
})

hl.monitor({ output = "desc:Microstep Optix MAG27CQ 0000000000001", mode = "2560x1440@144", position = "3440x0", scale = 1 })

-- Portrait side monitor
hl.monitor({ output = "desc:HP Inc. HP E24 G4 CN41450LKG", mode = "1920x1080@60", position = "2560x0", scale = 1, transform = 3 })
