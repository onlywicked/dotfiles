local wezterm = require "wezterm";

return {
	color_scheme = "catppuccin-mocha",
  font_size = 12,
  font = wezterm.font_with_fallback({
      "JetBrains Mono"
    }),
  hide_tab_bar_if_only_one_tab = true,
  window_decorations = "RESIZE",
}
