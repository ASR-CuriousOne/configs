vim.o.winborder = "rounded"
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.swapfile = false
vim.o.signcolumn = "yes"
vim.o.undofile = true
vim.o.termguicolors = true

vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>o', ":update<CR> :source<CR>")
vim.keymap.set('n', '<C-s>', ":write<CR>")
vim.keymap.set('n', '<leader>e', ":Ex<CR>")
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set({ 'n', 'v', 'x' }, '<C-c>', '"+y<CR>')
vim.pack.add({
	{ src = "https://github.com/tiagovla/tokyodark.nvim.git" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/xzbdmw/colorful-menu.nvim" },
	---{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	---{ src = "https://github.com/hrsh7th/cmp-buffer" },
	---{ src = "https://github.com/hrsh7th/cmp-path" },
	---{ src = "https://github.com/hrsh7th/cmp-cmdline" },
	---{ src = "https://github.com/hrsh7th/nvim-cmp" },
})
--- Telescope
require('telescope').setup({})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fa', builtin.find_files, { desc = 'Find all files' })

vim.keymap.set('n', '<leader>ff', function()
	builtin.find_files({
		search_dirs = { './src', './include' },
		hidden = true,  -- Include hidden files (optional)
		no_ignore = true, -- Include .gitignore'd files (optional)
	})
end, { desc = 'Find files in src and include' })

vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>pws', function()
	local word = vim.fn.expand("<cword>")
	builtin.grep_string({ search = word })
end)
vim.keymap.set('n', '<leader>pWs', function()
	local word = vim.fn.expand("<cWORD>")
	builtin.grep_string({ search = word })
end)
vim.keymap.set('n', '<leader>fw', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

--Treesitter
require "nvim-treesitter".setup({
	ensure_installed = {
		"lua", "vim", "vimdoc",
		"python",
		"javascript", "json", "typescript",
		"html", "css",
		"toml", "markdown",
		"bash",
		"cpp", "c",
		"go",
		"glsl" }, -- Add languages you use

	sync_install = true,
	auto_install = true,
	highlight = { enable = true },
	fold = { enable = true },
})
--Theme
require("tokyodark").setup({ transparent_background = true })
vim.cmd("colorscheme tokyodark")
--LSP setup
--
--Mason
require "mason".setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	}
})

---cmp
require("colorful-menu").setup({})
require "blink-cmp".setup({
	keymap = {
		preset = "default",
		["<Tab>"] = { "accept", "fallback" },        -- accept suggestion if menu open, else Tab
		["<S-Tab>"] = { "select_prev", "fallback" }, -- shift-tab goes to previous
	},
	appearance = { nerd_font_variant = 'mono' },
	completion = {
		menu = {
			draw = {
				-- We don't need label_description now because label and label_description are already
				-- combined together in label by colorful-menu.nvim.
				columns = { { "kind_icon" }, { "label", gap = 1 } },
				components = {
					label = {
						text = function(ctx)
							return require("colorful-menu").blink_components_text(ctx)
						end,
						highlight = function(ctx)
							return require("colorful-menu").blink_components_highlight(ctx)
						end,
					},
				},
			},
		},
	},
	sources = { default = { 'lsp', 'path', 'buffer' } },
	fuzzy = { implementation = "lua" },
})

---
local capabilities = require('blink-cmp').get_lsp_capabilities()

local lsp_servers = { "lua_ls", "clangd", "pyright", "ts_ls", "css_lsp", "html", "javascript", "typescript","prisma-language-server" }

for _, lsp in ipairs(lsp_servers) do
	vim.lsp.enable(lsp)
	vim.lsp.config(lsp, {
		capabilities = capabilities
	})
end

vim.diagnostic.config({
	virtual_lines = {
		current_line = true
	}
})

---LuaLine
require "lualine".setup({ options = { theme = 'tokyodark' } })
