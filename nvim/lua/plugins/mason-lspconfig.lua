return {
  "williamboman/mason-lspconfig.nvim",
  lazy = false,

  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig"
  },

  config = function()
    require("mason").setup()
    require('mason-lspconfig').setup({
      ensure_installed = {
        'astro',
        'cssls',
        'dockerls',
        'docker_compose_language_service',
        'html',
        'jsonls',
        'tsserver',
        'lua_ls',
        'marksman',
        'volar',
        'yamlls'
      }
    })

    require("mason-lspconfig").setup_handlers {
      function (server_name)
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        require("lspconfig")[server_name].setup {
          capabilities = capabilities
        }
      end
    }
  end
}
