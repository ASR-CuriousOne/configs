vim.g.mapleader = " "

vim.keymap.set("n","<leader>e",vim.cmd.Ex)
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true, silent = true })  -- Copy to system clipboard
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })   -- Save with Ctrl+S

vim.keymap.set('n', '<C-a>', ':bprev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Tab>', ':bnext<CR>', { noremap = true, silent = true })
