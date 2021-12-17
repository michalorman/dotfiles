local M = {}

M.config = function()
  vim.g.tokyonight_style = "night"
  
  vim.cmd[[colorscheme tokyonight]]
end

return M
