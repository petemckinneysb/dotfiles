local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 28

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 18
config.color_scheme = "Catppuccin Mocha"

config.enable_tab_bar = false

return config
