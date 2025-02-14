vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "project files"})

-- Remap <C-v> to paste from system clipboard
vim.keymap.set('i', '<C-v>', '<C-r>+', { desc = 'Paste from system clipboard' }) -- Insert mode
vim.keymap.set('n', '<C-v>', '"+p', { desc = 'Paste from system clipboard' })    -- Normal mode
vim.keymap.set('c', '<C-v>', '<C-r>+', { desc = 'Paste from system clipboard' }) -- Command mode
