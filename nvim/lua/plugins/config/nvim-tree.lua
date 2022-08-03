local present, nvim_tree = pcall(require, 'nvim-tree')

if not present then
  return
end

nvim_tree.setup({})

local utils = require 'utils'
local map = utils.map

map('n', '<C-n>', ':NvimTreeToggle<cr>', { silent = true })

