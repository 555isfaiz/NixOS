lua << END
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
 {
 {
    "tiagovla/tokyodark.nvim",
    opts = {
        -- custom options here
    },
    config = function(_, opts)
        require("tokyodark").setup(opts) -- calling setup is optional
    end,
},
{
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim"
  }
},
{
  "folke/persistence.nvim",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  opts = {
    -- add any custom options here
  }
},
 'rebelot/kanagawa.nvim',
 'marko-cerovac/material.nvim',
 'nvim-neotest/nvim-nio',
 'Shatur/neovim-ayu',
  'goolord/alpha-nvim',
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  "folke/neodev.nvim",
   'goolord/alpha-nvim', -- Splash Screen
 'nvim-lualine/lualine.nvim', -- Status Bar
 'kvrohit/mellow.nvim', -- Color Scheme
 'ggandor/leap.nvim',
 'nvim-telescope/telescope-dap.nvim',
 'lukas-reineke/indent-blankline.nvim',
 'tpope/vim-repeat',
 'ggandor/flit.nvim',
 'aserowy/tmux.nvim',
 'jamestthompson3/nvim-remote-containers',
 'cshuaimin/ssr.nvim',
 'folke/tokyonight.nvim',
 'xiyaowong/transparent.nvim',
 'romgrk/barbar.nvim', -- Tabs
 'folke/which-key.nvim', -- Key Suggestions
 'nvim-tree/nvim-tree.lua', -- File Explorer
 'MunifTanjim/nui.nvim',
 'nvim-neo-tree/neo-tree.nvim',
 'nvim-telescope/telescope.nvim', -- File Search
 { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
 {'iamcco/markdown-preview.nvim', build = 'cd app && yarn install'}, -- Markdown Preview
 'rcarriga/nvim-notify', -- Notification Boxes
 'xiyaowong/nvim-transparent', -- Transparent Background
 {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
 'nvim-treesitter/nvim-treesitter-textobjects',
--  'wakatime/vim-wakatime' -- Time Logging
 'ap/vim-css-color', -- CSS Color Preview
 'kyazdani42/nvim-web-devicons', -- Status Bar Icons
 'ryanoasis/vim-devicons', -- Developer Icons
 'nvim-lua/plenary.nvim', -- Telescope Dependency
--  'sbdchd/neoformat' -- Auto formatter
 'folke/trouble.nvim', -- Error box
 'williamboman/mason.nvim',
 'williamboman/mason-lspconfig.nvim',
 'jay-babu/mason-nvim-dap.nvim',
 'mfussenegger/nvim-dap',
 'rcarriga/nvim-dap-ui',
 'mfussenegger/nvim-jdtls',
 'mfussenegger/nvim-dap-python',
 'LiadOz/nvim-dap-repl-highlights',
 'rcarriga/cmp-dap',
 'folke/neodev.nvim',
 'p00f/clangd_extensions.nvim',
 'numToStr/Comment.nvim',
 'slyces/hierarchy.nvim',
 'stevearc/conform.nvim',
 'lewis6991/hover.nvim',
 'folke/noice.nvim',
 'windwp/nvim-autopairs',
 'stevearc/aerial.nvim',
 'ray-x/lsp_signature.nvim',
 'lewis6991/gitsigns.nvim',
 -- 'airblade/vim-gitgutter',

-- Extra Syntax Highlighting
 'othree/html5.vim',
 'pangloss/vim-javascript',

-- Auto complete
 'neovim/nvim-lspconfig',
 'hrsh7th/cmp-nvim-lsp',
 'hrsh7th/cmp-buffer',
 'hrsh7th/cmp-path',
 'hrsh7th/cmp-cmdline',
 'hrsh7th/nvim-cmp',

-- For vsnip users.
--  'hrsh7th/cmp-vsnip'
--  'hrsh7th/vim-vsnip'

-- For luasnip users.
 'L3MON4D3/LuaSnip',
 'saadparwaiz1/cmp_luasnip'
},
{lockfile = os.getenv('HOME') .. "/.config/lazy-lock.json",})


END

" Reference additional plugin configuration
runtime ./plugins/alpha.vim
runtime ./plugins/lualine.vim
runtime ./plugins/telescope.vim
" runtime ./plugins/nvim-tree.vim
runtime ./plugins/neo-tree.vim
runtime ./plugins/nvim-treesitter.vim
runtime ./plugins/which-key.vim
runtime ./plugins/cmp.vim
runtime ./plugins/mason.vim
runtime ./plugins/dap.vim
runtime ./plugins/lsp.vim
runtime ./plugins/noice.vim
runtime ./plugins/tmux.vim
runtime ./plugins/neoformat.vim
runtime ./plugins/indentline.vim
runtime ./plugins/barbar.vim
runtime ./plugins/ssr.vim
runtime ./plugins/gitsigns.vim
runtime ./plugins/leap.vim
runtime ./plugins/transparent.vim
runtime ./plugins/trouble.vim
runtime ./plugins/persistence.vim
