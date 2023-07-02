-- Website: https://wezfurlong.org/wezterm
-- Config: https://wezfurlong.org/wezterm/config/lua/config/index.html
-- GitHub: https://github.com/wez/wezterm

local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- visuals
config.color_scheme = 'One Dark (Gogh)'
config.window_background_opacity = 0.99

config.colors = {
   foreground = '#AFB5C1', -- default: #abb2bf
   background = '#161a1d'
}

-- general
config.adjust_window_size_when_changing_font_size = false
config.check_for_updates = false
-- config.default_prog = { os.getenv("SHELL") }
-- config.disable_default_key_bindings = true
config.enable_tab_bar = false
config.font = wezterm.font_with_fallback({
   "FiraCode Nerd Font",
   "Fira Code",
   "Noto Sans Math",
   "Noto Sans Symbols 2"
})
config.font_size = 11
config.max_fps = 144
config.window_close_confirmation = "NeverPrompt"

-- keybinds
config.keys = {
   -- Copy/Paste TODO: needed?
   -- { key = "C", mods = "SHIFT|CTRL", action = wezterm.action.CopyTo("Clipboard") },
   -- { key = "V", mods = "SHIFT|CTRL", action = wezterm.action.PasteFrom("Clipboard") },
   {
      key = 'u',
      mods = 'CTRL',
      action = wezterm.action.ShowLauncher },
   {
      key = '9',
      mods = 'CTRL',
      action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|TABS|DOMAINS|KEY_ASSIGNMENTS|WORKSPACES|COMMANDS' },
  },
}

return config
