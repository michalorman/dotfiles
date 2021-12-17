local M = {}

M.mappings = function()
  local utils = require 'utils'
  local map = utils.map
  
  map('n', '<leader>c', ':G<cr>')
end

return M
