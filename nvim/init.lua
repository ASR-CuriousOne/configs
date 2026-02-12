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
vim.keymap.set('n', "<leader>o", ":update<CR> :source<CR>")
vim.keymap.set('n', "<leader>e", ":Ex<CR>")

vim.keymap.set({ 'n', 'v', 'x' }, '<C-c>', '"+y<CR>')



vim.pack.add({{ src = "https://github.com/tiagovla/tokyodark.nvim.git"}})
require("tokyodark").setup({ transparent_background = true })

local currentTheme = "tokyodark"

vim.cmd("colorscheme " .. currentTheme)

vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" }
})
require("lualine").setup({options = {theme = currentTheme}})

vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim"},
	{ src = "https://github.com/nvim-telescope/telescope.nvim"}
})
require('telescope').setup({})

local builtin = require("telescope.builtin")
vim.keymap.set('n', "<leader>ff", function()
	builtin.find_files({
		search_dirs = {"./src", "./include"},
		hidden = true,
		no_ignore = true,
	})
end, {desc = "Find files in src and include"})

vim.keymap.set('n', "<leader>fg", builtin.git_files, {})

vim.keymap.set('n', '<leader>fw', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fa', builtin.find_files, {})

vim.pack.add({{src = "https://github.com/nvim-treesitter/nvim-treesitter"}})
require("nvim-treesitter").setup({
	ensure_installed = {
		"lua", "vim", "vimdoc", "cpp", "c", "python", "rust", "bash", "go", "glsl",
		"vhdl"
	},
	sync_install = true,
	auto_install = true,
	highlight = {enable = true},
fold = {enable = true }
})

vim.pack.add({{ src = "https://github.com/mason-org/mason.nvim" }})
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	}
})

vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{src = "https://github.com/saghen/blink.cmp"},
	{src = "https://github.com/xzbdmw/colorful-menu.nvim"}
})

require("colorful-menu").setup({})
require "blink-cmp".setup({
	keymap = {
		preset = "default",
		["<Tab>"] = { "accept", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" }
	},
	appearance = { nerd_font_variant = 'mono' },
	completion = {
		trigger = {
			show_on_keyword = true,
			show_on_trigger_character = true
		},
		menu = {
			draw = {
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
	sources = { default = { 'lsp', 'path', 'buffer' } , min_keyword_length = 2,
	providers = {
		buffer = { score_offset = -3 }
	}
},
	fuzzy = { implementation = "prefer_rust" , use_proximity = true},
})

local capabilities = require('blink-cmp').get_lsp_capabilities()

local lsp_servers = {
	"lua_ls", "clangd", "pyright",
	"ts_ls", "css_lsp", "html",
	"javascript", "typescript",
	"prisma-language-server",
	"tinymist","rust_analyzer","gopls",
	"vhdl_ls"
}
for _, lsp in ipairs(lsp_servers) do
	vim.lsp.enable(lsp)
	vim.lsp.config(lsp, {
		capabilities = capabilities
	})
end

vim.lsp.enable("neocmake")
vim.lsp.config("neocmake", {cmd = {"neocmakelsp","stdio"}})

vim.diagnostic.config({
	virtual_lines = {
		current_line = true
	}
})
vim.keymap.set('n',"<leader>lf",vim.lsp.buf.format)

vim.pack.add({{src = "https://github.com/chomosuke/typst-preview.nvim"}})
require("typst-preview").setup({})



