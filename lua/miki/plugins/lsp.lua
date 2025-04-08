return {
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "mason.nvim", "mason-lspconfig.nvim" },
	},
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
		dependencies = { "nvim-vtsls" },
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
				["vtsls"] = function()
					require("lspconfig.configs").vtsls = require("vtsls").lspconfig
					require("lspconfig").vtsls.setup({
						settings = {
							typescript = {
								tsdk = "./.yarn/sdks/typescript/lib",
								implementationsCodeLens = {
									enabled = true,
									showOnInterfaceMethods = true,
								},
							},
							vtsls = {
								autoUseWorkspaceTsdk = true,
							},
						},
						on_attach = function(_, bufnr)
							vim.keymap.set("n", "gd", function()
								require("vtsls").commands.goto_source_definition(0)
							end, { buffer = bufnr })

							vim.keymap.set("n", "gR", function()
								require("vtsls").commands.file_references(0)
							end, { buffer = bufnr })
						end,
					})
				end,
			},
		},
	},
	{
		"yioneko/nvim-vtsls",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
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
