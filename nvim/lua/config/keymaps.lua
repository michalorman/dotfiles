local keymap = vim.keymap

keymap.set("n", "<Leader>w", "<cmd>:w!<CR>")

keymap.set("n", "<Tab>", ":bnext<CR>", { silent = true })
keymap.set("n", "<S-Tab>", ":bprevious<CR>", { silent = true })
keymap.set("n", "<leader>q", ":bw<cr>", { silent = true })
keymap.set("n", "qq", ":bw<cr>", { silent = true })

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

--- LSP
keymap.set("n", "gd", vim.lsp.buf.definition)
keymap.set("n", "gD", vim.lsp.buf.declaration)
keymap.set("n", "gi", vim.lsp.buf.implementation)
keymap.set("n", "gR", vim.lsp.buf.references)
keymap.set("n", "<leader>.", vim.lsp.buf.code_action)
keymap.set("n", "<leader><space>", vim.lsp.buf.code_action)
keymap.set("n", "<leader>a", vim.lsp.buf.code_action)

keymap.set("n", "K", vim.lsp.buf.hover)
keymap.set("n", "<space>D", vim.lsp.buf.type_definition)
keymap.set("n", "<space>rn", vim.lsp.buf.rename)
keymap.set("n", "<space>e", vim.diagnostic.open_float)
keymap.set("n", "[d", vim.diagnostic.goto_prev)
keymap.set("n", "]d", vim.diagnostic.goto_next)
keymap.set("n", "<space>f", function()
	vim.lsp.buf.format({ async = true })
end)
