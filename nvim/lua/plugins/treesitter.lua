return {
  "nvim-treesitter/nvim-treesitter",

  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,

  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "astro", "bash", "c", "cpp", "css", "graphql", "html", "java", "javascript", "json", "lua", "ruby", "rust",
        "typescript", "vim", "vimdoc", "vue", "xml", "yaml"
      },

      -- sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
