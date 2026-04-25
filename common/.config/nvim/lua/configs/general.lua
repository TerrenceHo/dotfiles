-- default ui options
vim.opt.lazyredraw = true
vim.opt.hidden = true

-- enable better colors with termgui
vim.opt.termguicolors = true

-- number bar
vim.opt.relativenumber = true
vim.opt.number = true

-- show the command with 2 bars, match possible commands
vim.opt.showcmd = true
vim.opt.cmdheight = 2
vim.opt.showmatch = true
vim.opt.wildmenu = true

-- tabbing
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Filetype overrides: 2-space tabs
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "html", "css", "c", "cpp" },
	callback = function()
		vim.bo.tabstop = 2
		vim.bo.shiftwidth = 2
	end,
})
-- vim.opt.textwidth = 80

-- correct splits behavior
vim.opt.splitbelow = true
vim.opt.splitright = true

-- misc settings
vim.opt.mouse = "" -- disable mouse
-- vim.opt.clipboard:append({
-- 	"unnamed",
-- 	"unnamedplus",
-- }) -- use the normal internal clipboard, not the system clipboard

-- TODO: make this more lua friendly in the future!
-- ensure nvim opens at the same location for a file
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = { "*" },
	callback = function()
		if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
			vim.api.nvim_exec("normal! g'\"", false)
		end
	end,
})

-- Filetypes
vim.filetype.add({
	pattern = {
		[".*.bazelrc"] = "bazelrc",
	},
})
