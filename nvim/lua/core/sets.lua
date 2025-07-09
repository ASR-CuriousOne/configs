vim.opt.clipboard = "unnamedplus"
vim.opt.number = true           -- Show line numbers
vim.opt.relativenumber = true    -- Relative line numbers
vim.opt.shiftwidth = 4           -- Shift 4 spaces when tab
vim.opt.tabstop = 4              -- 1 tab == 4 spaces
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.mouse = "a"              -- Enable mouse support
vim.opt.termguicolors = true     -- Enable 24-bit colors
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"cpp", "c"},
    callback = function()
        vim.bo.cindent = true
        vim.bo.cinoptions = vim.bo.cinoptions .. ",N-s"
    end,
})
