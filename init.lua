vim.cmd [[packadd packer.nvim]]

-- Simple requires
require('plugins')
require('telescope').setup{}
require('nvim-autopairs').setup{}

-- Assigned requires
local nvim_lsp = require('lspconfig')
local cmp = require'cmp'

-- Leader
vim.g.mapleader = " "

-- Vim commands (todo: convert)
vim.cmd [[
	set termguicolors
	set background = "dark"
  	colorscheme nord
	set completeopt=menu,menuone,noselect
]]

-- Netrw
-- Set the list style to a tree
vim.g.netrw_liststyle = 3
-- Remove banner from top
vim.g.netrw_banner = 0
-- Change whether files are opened by default in splits/new tabs
--vim.g.netrw_browse_split = 3

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')


  require "lsp_signature".on_attach()

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>ff', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Setup nvim-cmp.
-- make it work with cmp
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

cmp.setup({
   snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require("rust-tools").setup({ 
	server = {
    		on_attach = on_attach,
    		capabilities = capabilities,
    		flags = {
      			debounce_text_changes = 150,
    		}
	}
})

-- Treesitter
require'nvim-treesitter.configs'.setup {
    incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<Leader>nn",
          node_incremental = "<Leader>ni",
          scope_incremental = "<Leader>ns",
          node_decremental = "<Leader>nd",
        },
      },

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = true,

  -- List of parsers to ignore installing
  ignore_install = {},

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}

-- Treesitter-textobjects
require'nvim-treesitter.configs'.setup {
    textobjects = {
      select = {
        enable = true,
  
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
  
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["tsfo"] = "@function.outer",
          ["tsfi"] = "@function.inner",
          ["tsco"] = "@class.outer",
          ["tsso"] = "@statement.outer",
          -- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
          ["tse"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        
        },
        -- You can choose the select mode (default is charwise 'v')
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V', -- linewise
          ['@class.outer'] = '<c-v>', -- blockwise
        },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding xor succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        include_surrounding_whitespace = true,
      },
    },
  }

  require('lualine').setup {
  	options = {
    		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = '', right = ''},
		section_separators = { left = '', right = ''},
		disabled_filetypes = {
		statusline = {},
    		winbar = {},
    	},
    	ignore_focus = {},
    	always_divide_middle = true,
	globalstatus = false,
	refresh = {
		statusline = 1000,
		tabline = 1000,
		winbar = 1000,
    	}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

-- Custom leader mappings
-- Telescope
vim.api.nvim_set_keymap('n', '<Leader>tf', ':Telescope find_files<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>tb', ':Telescope buffers<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>tg', ':Telescope live_grep<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>tt', ':Telescope treesitter<cr>', {noremap = true})
-- Write, write quit, force quit
vim.api.nvim_set_keymap('n', '<Leader>ww', ':w<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>wq', ':wq<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>qq', ':q!<cr>', {noremap = true})

vim.api.nvim_set_keymap('n', '<C-j>', ':bnext<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-x>', ':bd<cr>', {noremap = true})
