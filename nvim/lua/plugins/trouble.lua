-- return {
--   "folke/trouble.nvim",
--   dependencies = { "nvim-tree/nvim-web-devicons" },
--   opts = {},
--
--   config = function()
--     local trouble = require("trouble")
--
--     vim.keymap.set("n", "<leader>xx", function()
--       trouble.toggle("document")
--     end)
--     vim.keymap.set("n", "<leader>xw", function()
--       trouble.toggle("workspace")
--     end)
--     vim.keymap.set("n", "<leader>xd", function()
--       trouble.toggle("document")
--     end)
--     vim.keymap.set("n", "<leader>xq", function()
--       trouble.toggle("quickfix")
--     end)
--     vim.keymap.set("n", "<leader>xl", function()
--       trouble.toggle("loclist")
--     end)
--     vim.keymap.set("n", "gr", function()
--       trouble.toggle("lsp_references")
--     end)
--   end,
-- }
return {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cS",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}
