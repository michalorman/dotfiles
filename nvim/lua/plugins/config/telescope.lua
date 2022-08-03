local utils = require 'utils'
local map = utils.map

map('n', '<C-p>', ':Telescope find_files <cr>', { silent = true })
map('n', 'ff', ':Telescope find_files <cr>', { silent = true })
map('n', 'fo', ':Telescope find_files <cr>', { silent = true })
map('n', '<leader>g', ':Telescope live_grep <cr>', { silent = true })
map('n', 'fb', ':Telescope buffers <cr>', { silent = true })
-- map('n', '<leader>.', ':Telescope lsp_code_actions theme=cursor<cr>', { silent = true })

-- set vim.ui.select to Telescope
-- https://github.com/nvim-telescope/telescope-ui-select.nvim

local present, telescope = pcall(require, 'telescope')

if not present then
  return
end

-- This is your opts table
telescope.setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }

      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      --   codeactions = false,
      -- }
    }
  }
}

telescope.load_extension("ui-select")
