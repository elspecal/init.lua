return {
	{
		"f-person/auto-dark-mode.nvim",
		opts = {},
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("rose-pine").setup({
				enable = {
					legacy_highlights = false,
				},
			})
			vim.cmd("colorscheme rose-pine")
		end
	},
}
