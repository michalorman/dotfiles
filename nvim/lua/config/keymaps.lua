local keymap = vim.keymap

keymap.set("n", "<Leader>w", "<cmd>:w!<CR>")

keymap.set("n", "<Tab>", ":bnext<CR>", { silent = true })
keymap.set("n", "<S-Tab>", ":bprevious<CR>", { silent = true })
keymap.set("n", "<leader>q", ":bw<cr>", { silent = true })

keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")

keymap.set("n", "<leader><cr>", ":noh<cr>", { silent = true })
keymap.set("n", "<leader>n", ":noh<cr>", { silent = true })

keymap.set("n", "H", "^")
keymap.set("n", "L", "$")

keymap.set("c", "%%", '<C-R>=expand("%:h")."/"<CR>')

keymap.set("i", "<C-u>", "<c-r>=trim(system('uuidgen'))<cr>")
keymap.set("n", "<C-u>", "i<c-r>=trim(system('uuidgen'))<cr><esc>")

keymap.set("n", "q", "<Nop>") -- disable recording

-- nvim-tree toggle
keymap.set("n", "<C-n>", ":NvimTreeToggle<cr>", { silent = true })

--- Telescope
keymap.set("n", "<C-p>", ":Telescope find_files <cr>", { silent = true })
keymap.set("n", "ff", ":Telescope find_files <cr>", { silent = true })
keymap.set("n", "fo", ":Telescope find_files <cr>", { silent = true })
keymap.set("n", "<leader>g", ":Telescope live_grep <cr>", { silent = true })
keymap.set("n", "fb", ":Telescope buffers <cr>", { silent = true })
-- keymap.set('n', '<leader>.', ':Telescope lsp_code_actions theme=cursor<cr>', { silent = true })

--- LSP
keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { silent = true })
keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { silent = true })
keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { silent = true })
keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { silent = true })
keymap.set("n", "<leader>.", "<cmd>lua vim.lsp.buf.code_action()<CR>", { silent = true })

keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { silent = true })
-- keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { silent = true })
keymap.set("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", { silent = true })
keymap.set("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", { silent = true })
keymap.set("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", { silent = true })
keymap.set("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { silent = true })
keymap.set("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { silent = true })
keymap.set("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", { silent = true })
keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { silent = true })
keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { silent = true })
keymap.set("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", { silent = true })
keymap.set("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", { silent = true })

-- trouble
keymap.set("n", "<leader>xx", function()
	require("trouble").toggle()
end)
keymap.set("n", "<leader>xw", function()
	require("trouble").toggle("workspace_diagnostics")
end)
keymap.set("n", "<leader>xd", function()
	require("trouble").toggle("document_diagnostics")
end)
keymap.set("n", "<leader>xq", function()
	require("trouble").toggle("quickfix")
end)
keymap.set("n", "<leader>xl", function()
	require("trouble").toggle("loclist")
end)
keymap.set("n", "gR", function()
	require("trouble").toggle("lsp_references")
end)

-- Neogit
keymap.set("n", "<leader>c", function()
	require("neogit").open()
end)
keymap.set("n", "<leader>cc", function()
	require("neogit").open({ "commit" })
end)
