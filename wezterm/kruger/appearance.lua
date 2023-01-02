local module = {}

local wezterm = require 'wezterm';

module.font = wezterm.font("JetBrains Mono")
module.font_size = 18.0
module.audible_bell = "Disabled"
-- module.color_scheme = "ayu",
module.window_frame = {
    font_size = 18.0,
  }
module.window_padding = {
    left = 2,
    right = 2,
    top = 0,
    bottom = 0,
  }
module.colors = {
      -- Should probably use format-tab-title event intead: https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html
      --[[ tab_bar = { ]]
      --[[     -- The color of the strip that goes along the top of the window ]]
      --[[     background = "#FFFFFF", ]]
      --[[]]
      --[[     -- The active tab is the one that has focus in the window ]]
      --[[     active_tab = { ]]
      --[[         -- The color of the background area for the tab ]]
      --[[         bg_color = "#FFFFFF", ]]
      --[[         -- The color of the text for the tab ]]
      --[[         fg_color = "#000000", ]]
      --[[         -- Specify whether you want "Half", "Normal" or "Bold" intensity for the ]]
      --[[         -- label shown for this tab. ]]
      --[[         -- The default is "Normal" ]]
      --[[         intensity = "Bold", ]]
      --[[         underline = "None", ]]
      --[[         italic = false, ]]
      --[[         strikethrough = false, ]]
      --[[     }, ]]
      --[[     -- Inactive tabs are the tabs that do not have focus ]]
      --[[     inactive_tab = { ]]
      --[[         bg_color = "#202020", ]]
      --[[         fg_color = "#808080", ]]
      --[[     }, ]]
      --[[     -- alternate styling when the mouse pointer moves over inactive tabs ]]
      --[[     inactive_tab_hover = { ]]
      --[[         bg_color = "#363636", ]]
      --[[         fg_color = "#909090", ]]
      --[[         italic = false, ]]
      --[[     } ]]
      --[[ } ]]
  } 


return module
