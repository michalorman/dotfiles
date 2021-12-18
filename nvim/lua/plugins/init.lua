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
      require('plugins.tokyonight').config()
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
      require('plugins.telescope').mappings()
    end,
  }

  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('plugins.bufferline').setup()
    end,
  }

  use {
    "lukas-reineke/indent-blankline.nvim",

    config = function()
      require('plugins.indent-blankline').setup()
    end,
  }

  use {
    'famiu/feline.nvim',
    
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    
    config = function()
      require('plugins.feline').setup()
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
      require('plugins.fugitive').mappings()
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
    config = function()
      require('plugins.quickscope').setup()
    end,
  }

  use {
    "luukvbaal/stabilize.nvim",
    config = function() require("stabilize").setup() end,
  }

  use {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require 'plugins.lspconfig'

      lspconfig.setup()
      lspconfig.mappings()
    end,
  }

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'

  use {
    'prettier/vim-prettier',

    config = function()
      local prettier = require 'plugins.prettier'

      prettier.setup()
      prettier.mappings()
    end,
  }

  use {
    'kyazdani42/nvim-tree.lua',

    requires = {
      'kyazdani42/nvim-web-devicons',
    },

    config = function()
      local nvim_tree = require 'plugins.nvim-tree'

      nvim_tree.setup()
      nvim_tree.mappings()
    end,
  }

  use {
    'glepnir/dashboard-nvim',

    config = function()
      require('plugins.dashboard-nvim').setup()
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
