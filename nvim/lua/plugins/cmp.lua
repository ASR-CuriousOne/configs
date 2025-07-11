return{
	{"hrsh7th/nvim-cmp"},
	{"hrsh7th/cmp-buffer"},
	{"hrsh7th/cmp-path"},
	{"hrsh7th/cmp-nvim-lsp"},
	{"hrsh7th/cmp-nvim-lua"},
	{"onsails/lspkind.nvim"},
	{'hrsh7th/vim-vsnip'},
    {'hrsh7th/vim-vsnip-integ'},
	{"saadparwaiz1/cmp_luasnip",
	config = function()
		local cmp = require'cmp'

		-- Check if there's a word before the cursor (used by <TAB> mapping)
		local has_words_before = function()
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		-- Send feed keys with special codes (used by <S-TAB> mapping)
		local feedkey = function(key, mode)
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
		end
		cmp.setup {
			snippet = {
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body)
				end,
			},
			mapping = {
				['<C-d>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-j>'] = cmp.mapping.select_next_item(),
				['<C-k>'] = cmp.mapping.select_prev_item(),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm({ select = false }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif vim.fn["vsnip#available"]() == 1 then
						feedkey("<Plug>(vsnip-expand-or-jump)", "")
					--elseif has_words_before() then
					--	cmp.complete()
					else
						fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function()
					if cmp.visible() then
						cmp.select_prev_item()
					elseif vim.fn["vsnip#jumpable"](-1) == 1 then
						feedkey("<Plug>(vsnip-jump-prev)", "")
					end
				end, { "i", "s" }),

			},
			sources = {
				{ name = 'nvim_lsp' },
				{ name = 'vsnip' },
				{
					name = 'buffer',
					option = {
						-- complete from all buffers
						get_bufnrs = function()
							return vim.api.nvim_list_bufs()
						end
					},
				},
				{ name = 'nvim_lua' },
				{ name = 'path' },
			},
			formatting = {
				format = require("lspkind").cmp_format({with_text = true, menu = ({
					buffer = "[Buffer]",
					nvim_lsp = "[LSP]",
					vsnip = "[Vsnip]",
					nvim_lua = "[Lua]",
					path = "[Path]",
				})}),
			},
		}

	end
	},

	{"L3MON4D3/LuaSnip"},
	{"rafamadriz/friendly-snippets"}
	

}
