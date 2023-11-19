-- in case we'd like to use it somewhere
vim.g._theme = 'tokyonight'

local success, _ = pcall(vim.cmd, 'colorscheme ' .. vim.g._theme)

if not success then
  vim.notify('colorscheme ' .. vim.g._theme .. ' not found, falling back to default')
  return
end
