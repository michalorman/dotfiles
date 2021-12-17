local M = {}

local lsp = require "feline.providers.lsp"
local vi_mode = require 'feline.providers.vi_mode'

-- Get this from the theme package
local theme_colors = {
  none = "NONE",
  -- bg_dark = "#1f2335",
  bg_dark = "#16161e",
  -- bg = "#24283b",
  bg = "#1a1b26",
  bg_highlight = "#292e42",
  terminal_black = "#414868",
  fg = "#c0caf5",
  fg_dark = "#a9b1d6",
  fg_gutter = "#3b4261",
  dark3 = "#545c7e",
  comment = "#565f89",
  dark5 = "#737aa2",
  blue0 = "#3d59a1",
  blue = "#7aa2f7",
  cyan = "#7dcfff",
  blue1 = "#2ac3de",
  blue2 = "#0db9d7",
  blue5 = "#89ddff",
  blue6 = "#B4F9F8",
  blue7 = "#394b70",
  magenta = "#bb9af7",
  magenta2 = "#ff007c",
  purple = "#9d7cd8",
  orange = "#ff9e64",
  yellow = "#e0af68",
  green = "#9ece6a",
  green1 = "#73daca",
  green2 = "#41a6b5",
  teal = "#1abc9c",
  red = "#f7768e",
  red1 = "#db4b4b",
  git = { change = "#6183bb", add = "#449dab", delete = "#914c54", conflict = "#bb7a61" },
  gitSigns = { add = "#164846", change = "#394b70", delete = "#823c41" },
}

local colors = {
  bg_dark = theme_colors.bg_dark,
  bg = theme_colors.bg,
  bg_lighter_1 = '#24283b',
  bg_lighter_2 = theme_colors.bg_highlight,
  
  fg = theme_colors.fg_gutter,
  fg_lighter_1 = theme_colors.fg_dark,
  fg_lighter_2 = theme_colors.fg,

  blue = theme_colors.blue,
  dark_blue = theme_colors.blue0,
  blue2 = theme_colors.blue7,
  light_blue = theme_colors.blue5,

  yellow = theme_colors.yellow,
  red = theme_colors.red,
  green = theme_colors.green,
  cyan = theme_colors.cyan,
  orange = theme_colors.orange,
  magenta = theme_colors.magenta,
  teal = theme_colors.teal,
}

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

    hl = {
      fg = colors.bg,
      bg = colors.blue,
    },

    left_sep = {
      str = ' ' .. icons.round.left,
      hl = {
        fg = colors.blue,
        bg = colors.bg,
      }
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

  feline.setup({
    components = components,
    colors = colors
  })
end

return M
