local present, lsp_installer = pcall(require, 'nvim-lsp-installer')

if not present then
  return
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)


lsp_installer.on_server_ready(function(server)
  local opts = {
    capabilities = capabilities
  }

  if server.name == 'sumneko_lua' then
    opts.settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }
        }
      }
    }
  end

  server:setup(opts)
end)
