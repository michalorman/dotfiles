local utils = require 'utils'
local map = utils.map

map('n', '<C-p>', ':Telescope find_files <cr>', { silent = true })
map('n', 'ff', ':Telescope find_files <cr>', { silent = true })
map('n', 'fo', ':Telescope find_files <cr>', { silent = true })
map('n', '<leader>g', ':Telescope live_grep <cr>', { silent = true })
map('n', 'fb', ':Telescope buffers <cr>', { silent = true })
