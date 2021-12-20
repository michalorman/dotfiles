local packer = require 'packer'

local use = packer.use

-- Automatically execute PackerCompile whenever plugins.lua gets updated
vim.cmd([[
augroup packer_user_config
  autocmd!
  autocmd BufWritePost init.lua source <afile> | PackerCompile
augroup end
]])

return packer.startup(function()
  use 'wbthomason/packer.nvim'

  use {
    'folke/tokyonight.nvim',
    config = function()
      require 'plugins.config.tokyonight'
    end,
  }

  use {
    "max397574/better-escape.nvim",
    config = function() require("better_escape").setup() end,
  }

  use {
    'nvim-telescope/telescope.nvim',

    requires = {
      'nvim-lua/plenary.nvim'
    },

    config = function()
      require 'plugins.config.telescope'
    end,
  }

  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require 'plugins.config.bufferline'
    end,
  }

  use {
    "lukas-reineke/indent-blankline.nvim",

    config = function()
      require 'plugins.config.indent-blankline'
    end,
  }

  use {
    'famiu/feline.nvim',

    requires = {
      'kyazdani42/nvim-web-devicons',
    },

    config = function()
      require 'plugins.config.feline'
    end,
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup({
        signcolumn = false
      })
    end
  }

  use 'pangloss/vim-javascript'
  use 'editorconfig/editorconfig-vim'
  use 'posva/vim-vue'
  use 'tpope/vim-surround'

  use {
    'tpope/vim-fugitive',
    config = function()
      require 'plugins.config.fugitive'
    end,
  }

  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end,
  }

  use {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup{} end,
  }

  use 'karb94/neoscroll.nvim'
  use 'dag/vim-fish'

  use {
    'unblevable/quick-scope',

    setup = function()
      require 'plugins.config.quickscope'
    end,
  }

  use {
    "luukvbaal/stabilize.nvim",
    config = function() require("stabilize").setup() end,
  }

  use {
    'neovim/nvim-lspconfig',

    config = function()
      require 'plugins.config.lspconfig'
    end,
  }

  use {
    'williamboman/nvim-lsp-installer',

    config = function()
      require 'plugins.config.nvim-lsp-installer'
    end,
  }

  use {
    'hrsh7th/nvim-cmp',

    requires = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },

    config = function()
      require 'plugins.config.nvim-cmp'
    end,
  }

  use {
    'prettier/vim-prettier',

    config = function()
      require 'plugins.config.prettier'
    end,
  }

  use {
    'kyazdani42/nvim-tree.lua',

    requires = {
      'kyazdani42/nvim-web-devicons',
    },

    config = function()
      require 'plugins.config.nvim-tree'
    end,
  }

  use {
    'glepnir/dashboard-nvim',

    config = function()
      require 'plugins.config.dashboard-nvim'
    end,
  }

  use "nathom/filetype.nvim"

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

end)
