-- split navigation shortcuts
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")
vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
vim.keymap.set("n", "<C-L>", "<C-W><C-L>")

-- general keybindings
vim.keymap.set("n", "<leader>w", ":w<CR>")
-- vim.keymap.set('n', '<leader>d', ':bd')             -- delete the current buffer
vim.keymap.set("n", "<leader>l", ":nohlsearch<CR>") -- get rid of the highlights

-- folding
vim.keymap.set("n", "<Tab>", "za", { desc = "Toggle fold" })
vim.keymap.set("n", "<S-Tab>", "zA", { desc = "Toggle fold recursively" })

-- system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y') -- copy into system clipboard
vim.keymap.set("n", "<leader>Y", '"+y$') -- copy rest of line into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p') -- paste from system clipboard
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P') -- paste from system clipboard

-- fzf search utilities
vim.keymap.set("n", "<leader>f", function()
	require("fzf-lua").files()
end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>b", function()
	require("fzf-lua").buffers()
end, { desc = "Find Buffers" })

-- live grep across your project
vim.keymap.set("n", "<leader>gg", function()
	require("fzf-lua").live_grep()
end, { desc = "Live grep" })

-- grep the word under cursor
vim.keymap.set("n", "<leader>gw", function()
	require("fzf-lua").grep_cword()
end, { desc = "Grep word under cursor" })

-- grep inside the current buffer only
vim.keymap.set("n", "<leader>gb", function()
	require("fzf-lua").lgrep_curbuf()
end, { desc = "Grep current buffer" })

-- Autocomplete (enable by default, turn it off with keymap)
-- menu: show the completion popup menu at all. Without this, completions would just insert directly without showing you choices.
-- menuone: show the menu even when there's only one match. Without this, a single match gets inserted automatically with no menu, which can be jarring since you didn't get to confirm it.
-- noselect: don't pre-select the first item. The menu opens but nothing is highlighted, so you have to explicitly pick something with <C-n> or arrow keys. The alternative is noinsert, which highlights the first item but doesn't insert its text until you confirm. Without either, Neovim highlights and inserts the first match immediately, which most people find annoying.
-- popup: show documentation/details in a floating window next to the menu rather than in the preview window (which splits your editor). This is the modern look you'd expect from VS Code-style completions.
-- fuzzy: enables fuzzy matching in the completion menu, so typing fn could match function_name. This is a newer addition.
-- nearest: sorts matches by proximity to the cursor rather than alphabetically. Added in 0.12.
vim.o.autocomplete = true
vim.opt.completeopt = "menu,menuone,noselect,popup,nearest,fuzzy"
vim.keymap.set("n", "<leader>A", function()
	vim.o.autocomplete = not vim.o.autocomplete
	if vim.o.autocomplete then
		print("Autocomplete ON")
	else
		print("Autocomplete OFF")
	end
end, { desc = "Toggle autocomplete" })
-- Allow Tab autocomplete
vim.keymap.set("i", "<Tab>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-n>" -- next item
	else
		return "<Tab>" -- regular tab
	end
end, { expr = true })

vim.keymap.set("i", "<S-Tab>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-p>" -- previous item
	else
		return "<S-Tab>"
	end
end, { expr = true })
