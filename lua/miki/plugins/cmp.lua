return {
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = "rafamadriz/friendly-snippets",
		event ={ "InsertEnter", "CmdlineEnter" },

		-- use a release tag to download pre-built binaries
		version = "*",

		---@module "blink.cmp"
		---@type blink.cmp.Config
		opts = {
			cmdline = {
				completion = {
					list = {
						selection = {
							preselect = false,
						},
					},
					menu = {
						auto_show = true
					},
				},
			},
			-- 'default' for mappings similar to built-in completion
			keymap = {
				preset = "default",
				["<C-space>"] = {},
				["<C-j>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-b>"] = { "snippet_backward", "fallback" },
				["<C-f>"] = { "snippet_forward", "fallback" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
			},
			appearance = {
				-- Sets the fallback highlight groups to nvim-cmp's highlight groups
				-- Useful for when your theme doesn't support blink.cmp
				-- Will be removed in a future release
				use_nvim_cmp_as_default = true,
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "normal"
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
					}
				}
			},
			completion = {
				menu = {
					border = "rounded",
					draw = {
						columns = {
							{ "label_description", "label", gap = 1 },
							{ "kind_icon", "kind", gap = 1 },
							{ "source_name" },
						}
					}
				},
				documentation = {
					window = { border = "rounded" },
				}
			}
		},
		opts_extend = { "sources.default" }
	},
	{
		"hrsh7th/nvim-cmp",
		enabled = false,
		event = "InsertEnter",
		dependencies = {
			{
				"garymjr/nvim-snippets",
				dependencies = { "rafamadriz/friendly-snippets" },
				opts = {
					friendly_snippets = true,
				},
				keys = {
					{
						"<C-f>",
						function()
							if vim.snippet.active({ direction = 1 }) then
								vim.schedule(function()
									vim.snippet.jump(1)
								end)
								return
							end
							return "<C-f>"
						end,
						expr = true,
						silent = true,
						mode = { "i", "s" },
					},
					{
						"<C-b>",
						function()
							if vim.snippet.active({ direction = -1 }) then
								vim.schedule(function()
									vim.snippet.jump(-1)
								end)
								return
							end
							return "<C-b>"
						end,
						expr = true,
						silent = true,
						mode = { "i", "s" },
					},
				},
			},
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua",
			"onsails/lspkind.nvim",
		},
		opts = function()
			local cmp = require("cmp")

			return {
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
				}),
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				sources = cmp.config.sources({
					{ name = "buffer" },
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "nvim_lua" },
				}),
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				formatting = {
					fields = { "abbr", "kind", "menu" },
					format = require("lspkind").cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},
			}
		end,
		config = function (_, opts)
			local cmp = require("cmp")
			cmp.setup(opts)

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
						{ name = "cmdline" },
					}),
				matching = { disallow_symbol_nonprefix_matching = false },
			})
		end,
	},
}
