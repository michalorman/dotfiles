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

-- nvim-tree toggle
map('n', '<C-n>', ':NvimTreeToggle<cr>', { silent = true })

--- Telescope
map('n', '<C-p>', ':Telescope find_files <cr>', { silent = true })
map('n', 'ff', ':Telescope find_files <cr>', { silent = true })
map('n', 'fo', ':Telescope find_files <cr>', { silent = true })
map('n', '<leader>g', ':Telescope live_grep <cr>', { silent = true })
map('n', 'fb', ':Telescope buffers <cr>', { silent = true })
-- map('n', '<leader>.', ':Telescope lsp_code_actions theme=cursor<cr>', { silent = true })

--- LSP
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { silent = true })
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { silent = true })
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { silent = true })
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { silent = true })
map('n', '<leader>.', '<cmd>lua vim.lsp.buf.code_action()<CR>', { silent = true })

map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { silent = true })
-- map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { silent = true })
map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', { silent = true })
map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', { silent = true })
map('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', { silent = true })
map('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { silent = true })
map('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { silent = true })
map('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { silent = true })
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { silent = true })
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { silent = true })
map('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', { silent = true })
map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', { silent = true })

-- trouble
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)
