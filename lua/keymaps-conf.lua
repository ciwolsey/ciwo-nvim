-- Buffers
vim.api.nvim_set_keymap('n', '<C-j>', ':bnext<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-x>', ':bd<cr>', {noremap = true})
-- Telescope
vim.api.nvim_set_keymap('n', '<Leader>tf', ':Telescope find_files<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>tb', ':Telescope buffers<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>tg', ':Telescope live_grep<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>tt', ':Telescope treesitter<cr>', {noremap = true})
-- Write, write quit, force quit
vim.api.nvim_set_keymap('n', '<Leader>ww', ':w<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>wq', ':wq<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>qq', ':q!<cr>', {noremap = true})
-- Neotree
vim.api.nvim_set_keymap('n', '<Leader>b', ':Neotree toggle<cr>', {noremap = true})
