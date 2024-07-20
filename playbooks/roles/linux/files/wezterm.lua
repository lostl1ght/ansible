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
  window_padding = { left = 0, right = 0, top = 2, bottom = 0 },
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
  color_schemes = {
    ['kanagawa'] = {
      foreground = '#dcd7ba',
      background = '#1f1f28',
      cursor_fg = '#16161D',
      cursor_bg = '#c5c9c5',
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
    ['kanagawa-dragon'] = {
      foreground = '#c5c9c5',
      background = '#181616',
      cursor_fg = '#0d0c0c',
      cursor_bg = ' #c8c093',
      cursor_border = ' #c8c093',
      selection_fg = '#c8c093',
      selection_bg = '#2d4f67',
      scrollbar_thumb = '#0d0c0c',
      split = '#0d0c0c',
      ansi = {
        '#0d0c0c',
        '#c4746e',
        '#8a9a7b',
        '#c4b28a',
        '#8ba4b0',
        '#a292a3',
        '#8ea4a2',
        '#c8c093',
      },
      brights = {
        '#a6a69c',
        '#e46876',
        '#87a987',
        '#e6c384',
        '#7fb4ca',
        '#938aa9',
        '#7aa89f',
        '#c5c9c5',
      },
      indexed = { [16] = '#b6927b', [17] = '#b98d7b' },
    }
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
