local present, bufferline = pcall(require, 'bufferline')

if not present then
  return
end

local colors = require 'colors'

bufferline.setup({
  highlights = {
    background = {
      fg = colors.fg,
      bg = colors.bg_dark,
    },

    buffer_selected = {
      fg = colors.fg_lighter_2,
      bg = colors.bg,
      bold = true
    },

    close_button = {
      fg = colors.fg,
      bg = colors.bg_dark,
    },

    close_button_selected = {
      fg = colors.red,
      bg = colors.bg,
    },
  }
})
