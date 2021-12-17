
local M = {}

M.mappings = function()
  local utils = require 'utils'
  local map = utils.map
  
  map('n', '<C-p>', ':Telescope find_files <cr>', { silent = true })
  map('n', '<leader>g', ':Telescope live_grep <cr>', { silent = true })
end

return M
