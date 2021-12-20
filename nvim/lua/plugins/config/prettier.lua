vim.cmd([[
au BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.gql,*.md,*.vue PrettierAsync
]])

local utils = require 'utils'
local map = utils.map

map('n', '<leader>p', ':PrettierAsync<cr>')
