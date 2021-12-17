-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- map('n', '<leader>s', ':luafile $MYVIMRC<cr>')

map('n', '<Leader>w', '<cmd>:w!<CR>')

map('n', '<Tab>', ':bnext<CR>', { silent = true})
map('n', '<S-Tab>', ':bprevious<CR>', { silent = true})
map('n', '<C-w>', ':bw<cr>', { silent = true })

map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

map('n', '<leader><cr>', ':noh<cr>', { silent = true })
map('n', '<leader>n', ':noh<cr>', { silent = true })

map('n', 'H', '^')
map('n', 'L', '$')

map('c', '%%', '<C-R>=expand("%:h")."/"<CR>')

-- ------------------
-- Telescope

map('n', '<C-p>', ':Telescope find_files <cr>', { silent = true })
map('n', '<leader>g', ':Telescope live_grep <cr>', { silent = true })


-- ------------------
-- Fugitive

map('n', '<leader>c', ':G<cr>')

-- ------------------
-- coc

map('n', '<leader>.', '<Plug>(coc-codeaction)')
map('n', '<leader>e', ':CocCommand explorer<cr>')
map('n', '<leader>R', ':CocCommand workspace.renameCurrentFile')

-- ------------------
-- Prettier

map('n', '<leader>p', ':Prettier<cr>')
