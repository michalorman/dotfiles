local theme_colors = require("tokyonight.colors").setup({
  tokyonight_style = 'night'
})

return {
  bg_dark = theme_colors.bg_dark,
  bg = "#1a1b26",
  bg_highlight = theme_colors.bg_highlight,

  fg = theme_colors.fg_gutter,
  fg_lighter = theme_colors.fg_dark,

  blue = theme_colors.blue,
  dark_blue = theme_colors.blue0,
  light_blue = theme_colors.blue5,

  yellow = theme_colors.yellow,
  red = theme_colors.red,
  green = theme_colors.green,
  cyan = theme_colors.cyan,
  orange = theme_colors.orange,
  magenta = theme_colors.magenta,
  teal = theme_colors.teal,
}
