local M = {}

M.setup = function()
  -- Add additional capabilities supported by nvim-cmp
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  local lsp_installer = require("nvim-lsp-installer")

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
end

return M
