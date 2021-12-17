local M = {}

M.setup = function()
  local lspconfig = require('lspconfig')

  -- Add additional capabilities supported by nvim-cmp
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  local servers = { 'rust_analyzer', 'tsserver' }

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      capabilities = capabilities,
    }
  end

  -- nvim-cmp setup
  local cmp = require 'cmp'

  cmp.setup {
    -- snippet = {
    --   expand = function(args)
    --     require('luasnip').lsp_expand(args.body)
    --   end,
    -- },
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end,
      ['<S-Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end,
    },
    sources = {
      { name = 'nvim_lsp' },
      -- { name = 'luasnip' },
    },
  }
end

M.mappings = function()
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
end

return M
