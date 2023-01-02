local module = {}

module.unix_domains = { {
    -- The name; must be unique amongst all domains
      name = 'unix',}
    }
module.harfbuzz_features = {"zero"}
module.use_dead_keys = false
module.enable_scroll_bar = true
module.window_close_confirmation = "NeverPrompt"
module.initial_cols = 128
module.initial_rows = 52
module.hide_tab_bar_if_only_one_tab = true
module.native_macos_fullscreen_mode = true
module.automatically_reload_config = false

return module
