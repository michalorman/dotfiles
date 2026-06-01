local function github(repo)
  return "https://github.com/" .. repo
end

local any_version = vim.version.range("*")

vim.pack.add({
  { src = github("nvim-lua/plenary.nvim") },
  { src = github("nvim-tree/nvim-web-devicons") },
  { src = github("MunifTanjim/nui.nvim") },
  { src = github("rafamadriz/friendly-snippets") },
  { src = github("nvim-treesitter/nvim-treesitter") },
  { src = github("JoosepAlviste/nvim-ts-context-commentstring") },
  { src = github("folke/tokyonight.nvim") },
  { src = github("EdenEast/nightfox.nvim") },
  { src = github("catppuccin/nvim"), name = "catppuccin" },
  { src = github("folke/which-key.nvim") },
  { src = github("folke/trouble.nvim") },
  { src = github("folke/todo-comments.nvim") },
  { src = github("nvim-telescope/telescope.nvim"), version = "0.1.x" },
  { src = github("nvim-telescope/telescope-ui-select.nvim") },
  { src = github("nvim-tree/nvim-tree.lua"), version = any_version },
  { src = github("neovim/nvim-lspconfig") },
  { src = github("williamboman/mason.nvim") },
  { src = github("williamboman/mason-lspconfig.nvim") },
  { src = github("hrsh7th/nvim-cmp") },
  { src = github("hrsh7th/cmp-buffer") },
  { src = github("hrsh7th/cmp-nvim-lsp") },
  { src = github("NvChad/nvim-colorizer.lua") },
  { src = github("folke/noice.nvim") },
  { src = github("NeogitOrg/neogit") },
  { src = github("sindrets/diffview.nvim") },
  { src = github("ibhagwan/fzf-lua") },
  { src = github("echasnovski/mini.surround"), version = any_version },
  { src = github("echasnovski/mini.statusline"), version = any_version },
  { src = github("echasnovski/mini.pairs"), version = any_version },
  { src = github("echasnovski/mini.comment"), version = any_version },
  { src = github("stevearc/conform.nvim") },
  { src = github("saghen/blink.cmp"), version = vim.version.range("1.*") },
  { src = github("max397574/better-escape.nvim") },
  { src = github("folke/snacks.nvim") },
  { src = github("nickjvandyke/opencode.nvim") },
}, { load = true, confirm = true })
