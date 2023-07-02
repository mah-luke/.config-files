local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Ocean Dark (Gogh)'
config.window_background_opacity = 0.5


config.keys = {

   {
      key = '1',
      mods = 'ALT',
      action = wezterm.action.ShowLauncher },
   {
    key = '9',
    mods = 'ALT',
    action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|TABS' },
  },
}

return config
