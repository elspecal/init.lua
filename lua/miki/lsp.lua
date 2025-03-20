-- local defaults = require("lspconfig").util.default_config

-- defaults.capabilities =
-- 	vim.tbl_deep_extend("force", defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

vim.lsp.config("*", { capabilites = require("blink.cmp").get_lsp_capabilities() })
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '✘',
			[vim.diagnostic.severity.WARN] = '▲',
			[vim.diagnostic.severity.HINT] = '⚑',
			[vim.diagnostic.severity.INFO] = '»',
		},
	},
})
