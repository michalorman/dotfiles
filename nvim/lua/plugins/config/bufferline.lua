local present, bufferline = pcall(require, 'bufferline')

if not present then
  return
end

local colors = require 'colors'

bufferline.setup({
  highlights = {
    background = {
      guifg = colors.fg,
      guibg = colors.bg_dark,
    },

    buffer_selected = {
      guifg = colors.fg_lighter_2,
      guibg = colors.bg,
      gui = 'bold'
    },

    close_button = {
      guifg = colors.fg,
      guibg = colors.bg_dark,
    },

    close_button_selected = {
      guifg = colors.red,
      guibg = colors.bg,
    },
  }
})
