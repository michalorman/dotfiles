return {
  "neovim/nvim-lspconfig",
  lazy = false,

  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
  },

  config = function()
    require("mason").setup()

    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
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
    })

    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
      lspconfig[server_name].setup({
        capabilities = capabilities,
      })
    end

    local diagnostic_signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

    for type, icon in pairs(diagnostic_signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
  end,
}
