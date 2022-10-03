vim.cmd([[packadd packer.nvim]])

-- Simple requires
require("plugins")
require("telescope").setup({})

-- Netrw
-- Set the list style to a tree
vim.g.netrw_liststyle = 3
-- Remove banner from top
vim.g.netrw_banner = 0

require("sets-conf")
require("lspconfig-conf")
require("neovide-conf")
require("treesitter-conf")
require("lualine-conf")
require("neotree-conf")
require("keymaps-conf")
require("formatter-conf")
