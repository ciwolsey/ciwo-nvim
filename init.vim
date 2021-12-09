call plug#begin('~/.vim/plugged')
	Plug 'arcticicestudio/nord-vim'
	Plug 'neovim/nvim-lspconfig'
	Plug 'simrat39/rust-tools.nvim'

	" Optional dependencies
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'

	Plug 'mfussenegger/nvim-dap'

	" cmp
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'hrsh7th/cmp-vsnip'
	Plug 'hrsh7th/vim-vsnip'

	" signature help via lsp
	Plug 'ray-x/lsp_signature.nvim'

	Plug 'ggandor/lightspeed.nvim'
call plug#end()

set background = "dark"
set termguicolors
colorscheme nord

""""""""lua require('rust-tools').setup({})

lua << EOF
require('telescope').setup{
	defaults = {
	}
}
EOF


" leader key mapping
lua vim.g.mapleader = " "

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>ww <cmd>w<cr>
nnoremap <leader>wq <cmd>wq<cr>
nnoremap <leader>qq <cmd>q!<cr>

luafile ~/.config/nvim/lspconf.lua

set completeopt=menu,menuone,noselect


