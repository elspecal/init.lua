return {
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require("mini.files").setup()
			require("mini.pairs").setup({
				mappings = {
					["<"] = {
						action = "open",
						pair = "<>",
						neigh_pattern = "[^\\].",
					},
					[">"] = {
						action = "close",
						pair = "<>",
						neigh_pattern = "[^\\].",
					},
				},
			})
			require("mini.surround").setup()
			require("mini.basics").setup()
			require("mini.indentscope").setup()
		end,
	},
}
