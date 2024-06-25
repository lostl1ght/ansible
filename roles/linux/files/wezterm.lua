local wezterm = require('wezterm')
local act = wezterm.action
local mux = wezterm.mux

wezterm.on('gui-attached', function(_)
  local workspace = mux.get_active_workspace()
  for _, window in ipairs(mux.all_windows()) do
    if window:get_workspace() == workspace then
      window:gui_window():maximize()
    end
  end
end)

return {
  term = 'wezterm',
  font = wezterm.font({
    family = 'JetBrainsMono Nerd Font Mono',
    harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },
  }),
  font_rules = {
    {
      intensity = 'Bold',
      italic = false,
      font = wezterm.font({
        family = 'JetBrainsMono Nerd Font Mono',
        weight = 'Bold',
        stretch = 'Normal',
        style = 'Normal',
        harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },
      }),
    },
    {
      intensity = 'Bold',
      italic = true,
      font = wezterm.font({
        family = 'JetBrainsMono Nerd Font Mono',
        weight = 'Bold',
        stretch = 'Normal',
        style = 'Italic',
        harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },
      }),
    },
  },
  font_size = 9.0,
  color_scheme = 'kanagawa',
  -- force_reverse_video_cursor = true,
  color_schemes = {
    ['kanagawa'] = {
      foreground = '#dcd7ba',
      background = '#1f1f28',

      cursor_bg = '#c5c9c5',
      cursor_fg = '#16161D',
      cursor_border = '#c8c093',

      selection_fg = '#c8c093',
      selection_bg = '#2d4f67',

      scrollbar_thumb = '#16161d',
      split = '#16161d',

      ansi = {
        '#090618',
        '#c34043',
        '#76946a',
        '#c0a36e',
        '#7e9cd8',
        '#957fb8',
        '#6a9589',
        '#c8c093',
      },
      brights = {
        '#727169',
        '#e82424',
        '#98bb6c',
        '#e6c384',
        '#7fb4ca',
        '#938aa9',
        '#7aa89f',
        '#dcd7ba',
      },
      indexed = { [16] = '#ffa066', [17] = '#ff5d62' },
    },
    ['rose-pine'] = {
      foreground = '#e0def4',
      background = '#191724',

      cursor_bg = '#524f67',
      cursor_fg = '#e0def4',
      cursor_border = '#524f67',

      selection_bg = '#2a283e',
      selection_fg = '#e0def4',

      ansi = {
        '#26233a',
        '#eb6f92',
        '#31748f',
        '#f6c177',
        '#9ccfd8',
        '#c4a7e7',
        '#ebbcba',
        '#e0def4',
      },
      brights = {
        '#6e6a86',
        '#eb6f92',
        '#31748f',
        '#f6c177',
        '#9ccfd8',
        '#c4a7e7',
        '#ebbcba',
        '#e0def4',
      },
    },
  },
  disable_default_key_bindings = true,
  keys = {
    { key = 'C', mods = 'CTRL', action = act.CopyTo('Clipboard') },
    { key = 'V', mods = 'CTRL', action = act.PasteFrom('Clipboard') },
    { key = '0', mods = 'CTRL', action = act.ResetFontSize },
    { key = '=', mods = 'CTRL', action = act.IncreaseFontSize },
    { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
  },
  audible_bell = 'Disabled',
  default_prog = { 'powershell.exe' },
}
