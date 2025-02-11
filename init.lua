-- ===================
vim.opt.number = true           -- Show line numbers
vim.opt.relativenumber = true    -- Relative line numbers
vim.opt.cursorline = true        -- Highlight the current line
vim.opt.expandtab = true         -- Use spaces instead of tabs
vim.opt.shiftwidth = 4           -- Shift 4 spaces when tab
vim.opt.tabstop = 4              -- 1 tab == 4 spaces
vim.opt.smartindent = true       -- Automatically indent new lines
vim.opt.mouse = "a"              -- Enable mouse support
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.termguicolors = true     -- Enable 24-bit colors

-- ===================
-- Key Mappings
-- ===================
vim.g.mapleader = " "  -- Set leader key to space

-- Normal mode mappings
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })   -- Save with Ctrl+S
vim.api.nvim_set_keymap('n', '<C-q>', ':q<CR>', { noremap = true, silent = true })   -- Quit with Ctrl+Q

-- Move between windows with Ctrl+Arrow
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-x>', ':Ex<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-t>', ':Themery<CR>', { noremap = true, silent = false }) --Open Themery


-- Visual mode mappings
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true, silent = true })  -- Copy to system clipboard
-- ===================
-- Plugin Management (Packer)
-- ===================

-- Install packer.nvim if not already installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Auto reload Neovim when saving plugins.lua
vim.cmd [[autocmd BufWritePost init.lua source <afile> | PackerSync]]

-- Initialize packer
require('packer').startup(function(use)

  use 'jiangmiao/auto-pairs'
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Treesitter (Better Syntax Highlighting)
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'zaldih/themery.nvim'

  -- LSP Config
  use 'neovim/nvim-lspconfig'

  -- Autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',   -- LSP source for nvim-cmp
      'hrsh7th/cmp-buffer',     -- Buffer completions
      'hrsh7th/cmp-path',       -- Path completions
      'L3MON4D3/LuaSnip',       -- Snippet engine
      'saadparwaiz1/cmp_luasnip' -- Snippet completions
    }
  }

    use {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

    use 'mg979/vim-visual-multi'
  -- Gruvbox Theme
  use 'oxfist/night-owl.nvim'
  use 'morhetz/gruvbox'
  use 'rose-pine/neovim'
use 'loctvl842/monokai-pro.nvim'

local night_owl = require("night-owl")

-- 👇 Add your own personal settings here
--@param options Config|nil
night_owl.setup({
    -- These are the default settings
    bold = true,
    italics = true,
    underline = true,
    undercurl = true,
    transparent_background = true,
    cursorline = false,
    vim.cmd("highlight CursorLine ctermbg=NONE guibg=NONE"),
})

  use {
  "loctvl842/monokai-pro.nvim",
  config = function()
    require("monokai-pro").setup()
  end
}
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- ===================
-- Treesitter Setup
-- ===================
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "python", "javascript", "html", "css","json", "toml", "markdown", "bash","cpp", "c", "go" }, -- Add languages you use
  highlight = { enable = true }
}

-- ===================
-- LSP Configuration
-- ===================
local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true), -- Adds Neovim runtime to Lua LS
      },
    },
  },
}

lspconfig.pyright.setup{}    -- Python
lspconfig.ts_ls.setup{}   -- JavaScript/TypeScript
lspconfig.clangd.setup{}
lspconfig.gopls.setup {}

-- ===================
-- Autocompletion Setup (nvim-cmp)
-- ===================
local cmp = require'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)  -- LuaSnip expansion
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Accept completion
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },   -- LSP source
    { name = 'luasnip' },    -- Snippet source
  }, {
    { name = 'buffer' },     -- Buffer source
  })
}

-- ===================
-- Gruvbox Theme Setup
-- ===================
vim.cmd("colorscheme gruvbox")
vim.cmd("colorscheme rose-pine")
vim.cmd("colorscheme monokai-pro")
vim.cmd("colorscheme monokai-pro-octagon")
vim.cmd("colorscheme night-owl")

-- ===================
-- Additional Useful Settings
-- ===================
-- Automatically resize splits when resizing Neovim window
vim.cmd [[autocmd VimResized * wincmd =]]

-- Minimal config
require("themery").setup({
  themes = {"gruvbox", "rose-pine","monokai-pro-octagon","night-owl"}, -- Your list of installed colorschemes.
  livePreview = true, -- Apply theme while picking. Default to true.
})

vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "#1e1e2e" })



