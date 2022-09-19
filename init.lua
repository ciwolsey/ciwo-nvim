vim.cmd([[packadd packer.nvim]])

-- Simple requires
require("plugins")
require("telescope").setup({})
require("nvim-autopairs").setup({})

-- Assigned requires
local nvim_lsp = require("lspconfig")
local cmp = require("cmp")

-- Netrw
-- Set the list style to a tree
vim.g.netrw_liststyle = 3
-- Remove banner from top
vim.g.netrw_banner = 0
-- Change whether files are opened by default in splits/new tabs
-- vim.g.netrw_browse_split = 3

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

-- Setup nvim-cmp.
-- make it work with cmp
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on(
	"confirm_done",
	cmp_autopairs.on_confirm_done({
		map_char = {
			tex = "",
		},
	})
)

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
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({
			select = true,
		}),
	},
	sources = cmp.config.sources({
		{
			name = "nvim_lsp",
		},
		{
			name = "vsnip",
		}, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, { {
		name = "buffer",
	} }),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	sources = { {
		name = "buffer",
	} },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({ {
		name = "path",
	} }, { {
		name = "cmdline",
	} }),
})

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Treesitter-textobjects
require("neovide-conf")
require("sets-conf")
--require("rusttools-conf")
require("treesitter-conf")
require("lualine-conf")
require("neotree-conf")
require("keymaps-conf")
require("formatter-conf")
