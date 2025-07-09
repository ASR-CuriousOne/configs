return {
	"neovim/nvim-lspconfig",

	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},

	config = function()
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

		vim.diagnostic.config({ virtual_text = true })

		lspconfig.pyright.setup{}    -- Python
		lspconfig.ts_ls.setup{}   -- JavaScript/TypeScript
		lspconfig.clangd.setup{}
		lspconfig.gopls.setup {}

		vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

	end,
}
