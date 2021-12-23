local present, zenmode = pcall(require, 'zen-mode')

if not present then
  return
end

zenmode.setup({})

local utils = require 'utils'
local map = utils.map

map('n', '<leader>z', ':ZenMode<cr>', { silent = true })
