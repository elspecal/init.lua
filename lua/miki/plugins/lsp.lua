return {
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"williamboman/mason.nvim",
				cmd = "Mason",
				opts = {
					ui = {
						border = "rounded",
					},
				},
			},
			{
				"williamboman/mason-lspconfig.nvim",
				opts = {
					ensure_installed = { "lua_ls", "vtsls", "biome", "cssls", "html", "jsonls", "yamlls" },
					handlers = {
						function(server_name)
							require("lspconfig")[server_name].setup({})
						end,
						["lua_ls"] = function()
							require("lspconfig").lua_ls.setup({
								settings = {
									Lua = {
										diagnostics = {
											globals = { "vim" },
										},
									},
								},
							})
						end,
						["jsonls"] = function()
							require("lspconfig").jsonls.setup({
								settings = {
									json = {
										schemas = require("schemastore").json.schemas(),
										validate = { enable = true },
									},
								},
							})
						end,
						["yamlls"] = function()
							require("lspconfig").yamlls.setup({
								settings = {
									yaml = {
										schemaStore = {
											enable = false,
											url = "",
										},
										schemas = require("schemastore").yaml.schemas(),
									},
								},
							})
						end,
					},
				},
			},
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{
					path = "${3rd}/luv/library",
					words = { "vim%.uv" }
				},
				"lazy.nvim",
			},
		},
	},
}
