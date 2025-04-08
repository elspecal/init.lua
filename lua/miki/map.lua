vim.keymap.set({ "i", "v" }, "kj", "<Esc>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>e", function() MiniFiles.open() end, { noremap = true })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]])

vim.cmd("cnoreabbrev G Neogit")
