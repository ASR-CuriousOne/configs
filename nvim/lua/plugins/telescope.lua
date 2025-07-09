return {
    'nvim-telescope/telescope.nvim',
-- or                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' },
	
	  config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>fa', builtin.find_files, {})

		vim.keymap.set('n', '<leader>ff', function()
			builtin.find_files({
				search_dirs = { './src', './include' },
				hidden = true, -- Include hidden files (optional)
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
    end
}
