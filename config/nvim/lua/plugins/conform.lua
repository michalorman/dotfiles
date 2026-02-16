return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "oxfmt", "prettierd", "prettier", stop_after_first = true, },
      typescript = { "oxfmt", "prettierd", "prettier", stop_after_first = true, },
      vue = { "oxfmt", "prettierd", "prettier", stop_after_first = true, },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
