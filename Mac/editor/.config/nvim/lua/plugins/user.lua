---@type LazySpec
return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = true,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>",
					},
					layout = {
						position = "bottom", -- | top | left | right
						ratio = 0.4,
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					hide_during_completion = true,
					debounce = 75,
					keymap = {
						accept = "<Leader>,",
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
				copilot_node_command = "node", -- Node.js version must be > 18.x
				server_opts_overrides = {},
			})
		end,
	},
	{
		"sphamba/smear-cursor.nvim",
		opts = {
			stiffness = 0.8, -- 0.6      [0, 1]
			trailing_stiffness = 0.5, -- 0.3      [0, 1]
			distance_stop_animating = 0.5, -- 0.1      > 0
			hide_target_hack = false, -- true     boolean
		},
	},
	{
		"goolord/alpha-nvim",
		opts = function(_, opts)
			-- customize the dashboard header
			opts.section.header.val = {
				"  __      _____ ____",
				" /---__  ( (O)|/(O) )",
				"  \\\\\\\\/  \\___/U\\___/",
				"    L\\       ||",
				"     \\\\ ____|||_____",
				"      \\\\|==|[]__/==|\\-|",
				"       \\|* |||||\\==|/-|",
				"    ____| *|[][]-- |_",
				"   ||EEE|__EEEE_[]_|EE\\",
				"   ||EEE|=O     O|=|EEE|",
				"   \\LEEE|         \\|EEE|  __))",
				"                          ```",
			}
			return opts
		end,
	},
	"andweeb/presence.nvim",
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").setup()
		end,
	},
	{ "max397574/better-escape.nvim", enabled = false },
	{
		"L3MON4D3/LuaSnip",
		config = function(plugin, opts)
			require("astronvim.plugins.configs.luasnip")(plugin, opts) -- include the default astronvim config that calls the setup call
			-- add more custom luasnip configuration such as filetype extend or custom snippets
			local luasnip = require("luasnip")
			luasnip.filetype_extend("javascript", { "javascriptreact" })
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		config = function()
			local kanagawa = require("kanagawa")
			kanagawa.setup({
				transparent = true,
				theme = "wave",
			})
		end,
	},
	{ "m-pilia/vim-pkgbuild", lazy = false },
	{ "iamcco/markdown-preview.nvim", lazy = false },
	{
		"akinsho/git-conflict.nvim",
		config = function()
			require("git-conflict").setup({
				default_mappings = false,
			})
		end,
		lazy = false,
	},
	{ "folke/zen-mode.nvim", lazy = false },
	{ "mbbill/undotree", lazy = false },
	{ "tpope/vim-fugitive", lazy = false },
	{ "Eandrju/cellular-automaton.nvim", lazy = false },
	{ "segeljakt/vim-silicon", lazy = false },
	{ "TheBlob42/houdini.nvim", lazy = false },
	{ "mzlogin/vim-markdown-toc", lazy = false },
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").setup()
		end,
	},
	{
		"ruifm/gitlinker.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			local gitlinker = require("gitlinker")
			gitlinker.setup()
		end,
		lazy = false,
	},
	{
		"henriklovhaug/Preview.nvim",
		cmd = { "Preview" },
		config = function()
			require("preview").setup()
		end,
	},
}
