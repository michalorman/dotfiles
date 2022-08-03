local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Automatically execute PackerCompile whenever plugins.lua gets updated
vim.cmd([[
augroup packer_user_config
  autocmd!
  autocmd BufWritePost init.lua source <afile> | PackerCompile
augroup end
]])

local present, packer = pcall(require, 'packer')

if not present then
  return
end

local use = packer.use

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function()
  use 'wbthomason/packer.nvim'

  use 'folke/tokyonight.nvim'

  -- use 'EdenEast/nightfox.nvim'

  use {
    "max397574/better-escape.nvim",
    config = function() require("better_escape").setup() end,
  }

  use {
    'nvim-telescope/telescope.nvim',

    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim'
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
      'hrsh7th/cmp-nvim-lua',
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

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require 'plugins.config.treesitter'
    end,
  }

  use {
    "folke/zen-mode.nvim",
    -- requires = {
    --   "folke/twilight.nvim",
    -- },
    config = function()
      require 'plugins.config.zen-mode'
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
