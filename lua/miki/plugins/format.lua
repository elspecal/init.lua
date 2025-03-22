return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>fm",
				function()
					require("conform").format({ async = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			formatters = {
				biome = { require_cwd = true },
				prettierd = { require_cwd = true },
			},
			formatters_by_ft = {
				javascript = { "biome", "prettierd", stop_after_first = true },
				typescript = { "biome", "prettierd", stop_after_first = true },
				javascriptreact = { "biome", "prettierd", stop_after_first = true },
				typescriptreact = { "biome", "prettierd", stop_after_first = true },
			},
			default_format_opts = {
				lsp_format = "fallback"
			},
			format_on_save = {
				lsp_format = "fallback",
				timeout_ms = 500,
			},
		},
	},
}
