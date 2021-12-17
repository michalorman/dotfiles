local M = {}

M.setup = function()
  vim.cmd([[
  au BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.gql,*.md,*.vue PrettierAsync
  ]])
end

M.mappings = function()
  local utils = require 'utils'
  local map = utils.map
  
  map('n', '<leader>p', ':Prettier<cr>')
end

return M
