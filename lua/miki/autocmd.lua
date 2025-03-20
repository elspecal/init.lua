vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client == nil then
			return
		end

		if client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
		end

		if client:supports_method("textDocument/documentHighlight") then
			local autocmd = vim.api.nvim_create_autocmd
			local autogrp = vim.api.nvim_create_augroup("lsp_highlight", { clear = false })

			vim.api.nvim_clear_autocmds({ buffer = args.buf, group = autogrp })
			autocmd("CursorHold", {
				group = autogrp,
				buffer = args.buf,
				callback = vim.lsp.buf.document_highlight,
			})
			autocmd("CursorMoved", {
				group = autogrp,
				buffer = args.buf,
				callback = vim.lsp.buf.clear_references,
			})
		end
	end,
})
