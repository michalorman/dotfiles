local M = {}

local colors = require 'colors'

M.setup = function()
  local bufferline = require 'bufferline'

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
end

return M
