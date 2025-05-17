return {
  "mason-org/mason-lspconfig.nvim",

  dependencies = {
    "mason-org/mason.nvim",
  },

  opts = {
    ensure_installed = {
      "astro",
      "cssls",
      "dockerls",
      "docker_compose_language_service",
      "html",
      "jsonls",
      "tsserver",
      "lua_ls",
      "marksman",
      "volar",
      "yamlls",
    },
  },
}
