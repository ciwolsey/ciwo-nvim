return require('packer').startup(function()
        --Packer can manage itself
        use 'wbthomason/packer.nvim'
        use 'arcticicestudio/nord-vim'
        use 'neovim/nvim-lspconfig'
        use 'simrat39/rust-tools.nvim'

        -- Optional dependencies
        use 'nvim-lua/popup.nvim'
        use 'nvim-lua/plenary.nvim'
        use 'nvim-telescope/telescope.nvim'

        use 'mfussenegger/nvim-dap'

        -- cmp
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-path'
        use 'hrsh7th/cmp-cmdline'
        use 'hrsh7th/nvim-cmp'
        use 'hrsh7th/cmp-vsnip'
        use 'hrsh7th/vim-vsnip'

        -- signature help via lsp
        use 'ray-x/lsp_signature.nvim'

        -- movement
        use 'ggandor/lightspeed.nvim'

	-- autopairs
	use 'windwp/nvim-autopairs'
end)
