call plug#begin('~/.vim/plugged')
	Plug 'arcticicestudio/nord-vim'
	Plug 'neovim/nvim-lspconfig'
	Plug 'simrat39/rust-tools.nvim'

	" Optional dependencies
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'

	Plug 'mfussenegger/nvim-dap'
call plug#end()

set background = "dark"
set termguicolors
colorscheme nord

"lua require('rust-tools').setup({})
lua require('telescope').setup({});

" leader key mapping
lua vim.g.mapleader = " "

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>

luafile lspconf.lua
