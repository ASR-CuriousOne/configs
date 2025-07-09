return {
	-- the colorscheme should be available when starting Neovim
	{
		"tiagovla/tokyodark.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 100, -- make sure to load this before all the other start plugins
		opts = {transparent_background = true},
		config = function()
			require("tokyodark").setup({transparent_background = true})
			vim.cmd.colorscheme("tokyodark")
		end,
	},

	{
		"oxfist/night-owl.nvim",
  		lazy = false, -- make sure we load this during startup if it is your main colorscheme
  		priority = 1000, -- make sure to load this before all the other start plugins
  		config = function()
    		-- load the colorscheme here
    		require("night-owl").setup()
    		--vim.cmd.colorscheme("night-owl")
  		end,
	}
}
