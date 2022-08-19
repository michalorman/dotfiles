local utils = require 'utils'

local map = utils.map

map('n', '<Leader>w', '<cmd>:w!<CR>')

map('n', '<Tab>', ':bnext<CR>', { silent = true})
map('n', '<S-Tab>', ':bprevious<CR>', { silent = true})
map('n', '<leader>q', ':bw<cr>', { silent = true })

map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

map('n', '<leader><cr>', ':noh<cr>', { silent = true })
map('n', '<leader>n', ':noh<cr>', { silent = true })

map('n', 'H', '^')
map('n', 'L', '$')

map('c', '%%', '<C-R>=expand("%:h")."/"<CR>')

map("i", "<C-u>", "<c-r>=trim(system('uuidgen'))<cr>")
map("n", "<C-u>", "i<c-r>=trim(system('uuidgen'))<cr><esc>")
