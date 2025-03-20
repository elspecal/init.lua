vim.keymap.set({ "i", "v" }, "kj", "<Esc>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>e", function () MiniFiles.open() end, { noremap = true })
