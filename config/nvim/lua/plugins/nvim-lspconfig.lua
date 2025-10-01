return {
  "neovim/nvim-lspconfig",
  lazy = false,

  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
  },

  config = function()
    require("mason").setup()

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.lsp.config('*', {
      capabilities = capabilities,
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "astro",
        "cssls",
        "dockerls",
        "docker_compose_language_service",
        "html",
        "jsonls",
        "ts_ls",
        "lua_ls",
        "marksman",
        "volar",
        "yamlls",
      },
      automatic_enable = true, -- Automatically enables installed servers
    })

    local diagnostic_signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(diagnostic_signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
  end,
}
