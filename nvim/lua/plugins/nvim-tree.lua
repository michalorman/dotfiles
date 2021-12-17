local M = {}

M.setup = function()
  require('nvim-tree').setup({
    auto_close = true
  })
end

M.mappings = function()
  local utils = require 'utils'
  local map = utils.map
  
  map('n', '<C-n>', ':NvimTreeToggle<cr>', { silent = true })
end

return M
