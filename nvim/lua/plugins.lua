return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'folke/tokyonight.nvim'

  use {
    "max397574/better-escape.nvim",
    config = function() require("better_escape").setup() end,
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  
  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require('bufferline').setup() end,
  }

  use "lukas-reineke/indent-blankline.nvim"

  -- use 'famiu/feline.nvim'

  use 'itchyny/lightline.vim'
  use 'pangloss/vim-javascript'
  use 'editorconfig/editorconfig-vim'
  use 'posva/vim-vue'
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'

  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end,
  }

  use {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup{} end,
  }
  
  use {
    'neoclide/coc.nvim',
    branch = 'release'
  }
  
  use 'karb94/neoscroll.nvim'
  use 'dag/vim-fish'
  use 'unblevable/quick-scope'
  
  use {
    "luukvbaal/stabilize.nvim",
    config = function() require("stabilize").setup() end,
  }
  
  use 'prettier/vim-prettier'
end)
