local M = {}

local lsp = require "feline.providers.lsp"
local vi_mode = require 'feline.providers.vi_mode'
local colors = require 'colors'

local mode_hl = {
  ["n"] = {
    fg = colors.bg,
    bg = colors.blue,
  },
  ["no"] = {
    fg = colors.bg,
    bg = colors.red,
  },
  ["i"] = {
    fg = colors.bg,
    bg = colors.light_blue,
  },
  ["ic"] = {
    fg = colors.bg,
    bg = colors.light_blue,
  },
  ["t"] = {
    fg = colors.bg,
    bg = colors.green,
  },
  ["v"] = {
    fg = colors.bg,
    bg = colors.cyan,
  },
  ["V"] = {
    fg = colors.bg,
    bg = colors.cyan,
  },
  [""] = {
    fg = colors.bg,
    bg = colors.cyan,
  },
  ["R"] = {
    fg = colors.bg,
    bg = colors.orange,
  },
  ["Rv"] = {
    fg = colors.bg,
    bg = colors.orange,
  },
  ["s"] = {
    fg = colors.bg,
    bg = colors.dark_blue,
  },
  ["S"] = {
    fg = colors.bg,
    bg = colors.dark_blue,
  },
  [""] = {
    fg = colors.bg,
    bg = colors.dark_blue,
  },
  ["c"] = {
    fg = colors.bg,
    bg = colors.magenta,
  },
  ["cv"] = {
    fg = colors.bg,
    bg = colors.magenta,
  },
  ["ce"] = {
    fg = colors.bg,
    bg = colors.magenta,
  },
  ["r"] = {
    fg = colors.bg,
    bg = colors.teal,
  },
  ["rm"] = {
    fg = colors.bg,
    bg = colors.teal,
  },
  ["r?"] = {
    fg = colors.bg,
    bg = colors.teal,
  },
  ["!"] = {
    fg = colors.bg,
    bg = colors.green,
  },
}

local icons = {
  slant = {
    left = " ",
    right = " ",
  },

  round = {
    left = "",
    right = "",
  },
}

M.setup = function()
  local feline = require 'feline'

  local components = {
    active = {},
    inactive = {},
  }

  table.insert(components.active, {})
  table.insert(components.active, {})

  components.active[1][1] = {
    provider = function()
      return ' ' .. vi_mode.get_vim_mode()
    end,

    hl = function()
      return mode_hl[vim.fn.mode()]
    end,
  }

  components.active[1][2] = {
    provider = function()
      local filename = vim.fn.expand "%:t"
      local extension = vim.fn.expand "%:e"
      local icon = require("nvim-web-devicons").get_icon(filename, extension)
      if icon == nil then
        icon = " "
        return icon
      end
      return " " .. icon .. " " .. filename .. " "
    end,

    hl = {
      fg = colors.fg_lighter_1,
      bg = colors.bg_lighter_2,
    },

    left_sep = {
      str = icons.slant.left,
      hl = function()
        return {
          fg = colors.bg_lighter_2,
          bg = mode_hl[vim.fn.mode()].bg,
        }
      end,
    },
  }

  components.active[1][3] = {
    provider = function()
      local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      return "  " .. dir_name .. " "
    end,

    hl = {
      fg = colors.fg,
      bg = colors.bg,
    },

    left_sep = {
      str = icons.slant.left,

      hl = {
        fg = colors.bg,
        bg = colors.bg_lighter_2,
      },
    },
  }

  components.active[1][4] = {
    provider = "diagnostic_errors",
    enabled = function()
      return lsp.diagnostics_exist "Error"
    end,

    hl = { fg = colors.red },
    icon = "  ",
  }

  components.active[1][5] = {
    provider = "diagnostic_warnings",
    enabled = function()
      return lsp.diagnostics_exist "Warning"
    end,
    hl = { fg = colors.yellow },
    icon = "  ",
  }

  components.active[2][1] = {
    provider = function()
      if next(vim.lsp.buf_get_clients()) ~= nil then
        return "  LSP"
      else
        return ""
      end
    end,

    hl = {
      fg = colors.fg,
      bg = colors.bg,
    },

    right_sep = ' '
  }

  components.active[2][2] = {
    provider = 'git_branch',

    hl = {
      fg = colors.fg,
      bg = colors.bg,
    },

    icon = '  ',
  }

  components.active[2][3] = {
    provider = ' ',

    hl = function() 
      return {
        fg = colors.bg,
        bg = mode_hl[vim.fn.mode()].bg,
      }
    end,

    left_sep = {
      str = ' ' .. icons.round.left,
      hl = function() 
        return {
          fg = mode_hl[vim.fn.mode()].bg,
          bg = colors.bg,
        }
      end,
    },
  }

  components.active[2][4] = {
    provider = function()
      local current_line = vim.fn.line "."
      local total_line = vim.fn.line "$"

      if current_line == 1 then
        return " Top "
      elseif current_line == vim.fn.line "$" then
        return " Bot "
      end
      local result, _ = math.modf((current_line / total_line) * 100)
      return " " .. result .. "%% "
    end,

    hl = {
      fg = colors.fg_lighter_1,
      bg = colors.bg_lighter_2,
    },
  }
  
  table.insert(components.inactive, {})

  components.inactive[1][1] = {
    hl = {
      bg = colors.bg,
    },
  }

  feline.setup({
    components = components,
    colors = colors
  })
end

return M
