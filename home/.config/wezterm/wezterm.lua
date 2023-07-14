-- Website: https://wezfurlong.org/wezterm
-- Config: https://wezfurlong.org/wezterm/config/lua/config/index.html
-- GitHub: https://github.com/wez/wezterm

local wezterm = require("wezterm")
local keybinds = require("keybinds")
local config = wezterm.config_builder()

-- visuals
config.color_scheme = "One Dark (Gogh)"
config.window_background_opacity = 0.99

-- FIXME:  Fix terminal colors
config.colors = {
    foreground = "#AFB5C1", -- default: #abb2bf
    background = "#181a1f", -- default: #282c34

    -- Overrides the cell background color when the current cell is occupied by the
    -- cursor and the cursor style is set to Block
    -- cursor_bg = "hsl(219, 14%, 30%)",
    -- Overrides the text color when the current cell is occupied by the cursor
    cursor_fg = "#AFB5C1",
    cursor_bg = "hsl(220, 14%, 35%)",
    -- Specifies the border color of the cursor when the cursor style is set to Block,
    -- or the color of the vertical or horizontal bar when the cursor style is set to
    -- Bar or Underline.
    cursor_border = "red",

    -- the foreground color of selected text
    selection_fg = "afb5c1",
    -- the background color of selected text
    selection_bg = "282c34",
    -- When the IME, a dead key or a leader key are being processed and are effectively
    -- holding input pending the result of input composition, change the cursor
    -- to this color to give a visual cue about the compose state.
    compose_cursor = "orange",

    -- Colors for copy_mode and quick_select
    -- available since: 20220807-113146-c2fee766
    -- In copy_mode, the color of the active text is:
    -- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
    -- 2. selection_* otherwise
    -- copy_mode_active_highlight_bg = { Color = "#000000" },
    -- use `AnsiColor` to specify one of the ansi color palette values
    -- (index 0-15) using one of the names "Black", "Maroon", "Green",
    --  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
    -- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
    -- copy_mode_active_highlight_fg = { AnsiColor = "Black" },
    -- copy_mode_inactive_highlight_bg = { Color = "#52ad70" },
    -- copy_mode_inactive_highlight_fg = { AnsiColor = "White" },
    --
    -- quick_select_label_bg = { Color = "peru" },
    -- quick_select_label_fg = { Color = "#ffffff" },
    -- quick_select_match_bg = { AnsiColor = "Navy" },
    -- quick_select_match_fg = { Color = "#ffffff" },
}

-- general
config.adjust_window_size_when_changing_font_size = false
config.check_for_updates = false
config.default_prog = { os.getenv("SHELL") }
config.disable_default_key_bindings = true
config.enable_tab_bar = false
config.font = wezterm.font_with_fallback({
    "FiraCode Nerd Font",
    "Fira Code",
    "Noto Sans Math",
    "Noto Sans Symbols 2",
})
config.font_size = 11
config.max_fps = 144
config.window_close_confirmation = "NeverPrompt"
config.keys = keybinds.keys
config.key_tables = keybinds.key_tables

return config
