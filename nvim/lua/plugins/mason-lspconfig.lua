return{
	'williamboman/mason-lspconfig.nvim',

	dependencies = {'williamboman/mason.nvim'},

	config = function()
		require("mason-lspconfig").setup {
			ensure_installed = { "lua_ls", "rust_analyzer" , "clangd"},
		}
	end
}	
