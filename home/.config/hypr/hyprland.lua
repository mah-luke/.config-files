-- Hyprland Lua config, migrated from hyprland.conf (kept as reference).
-- See https://wiki.hypr.land/configuring/
--
-- Each require() is an isolated scope: a broken module does not take down
-- the rest of the config.

require("lua.monitors")
require("lua.options")
require("lua.rules")
require("lua.keybinds")
require("lua.autostart")