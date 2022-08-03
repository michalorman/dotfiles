local signs = { Error = "﮻ ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local config = {
  virtual_text = false,

  update_in_insert = true,
  severity_sort = true,

  float = {
    focusable = false,
    style = "minimal",
    -- border = "rounded",
    source = "if_many",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(config)

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

local utils = require 'utils'
local map = utils.map

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
