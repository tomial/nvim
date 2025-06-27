vim.cmd("syntax enable")
-- 设置 Neovim 消息语言为中文 (可选, 更推荐通过环境变量 LANG)
-- vim.cmd('language zh_CN.UTF-8')
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.cmd("filetype plugin indent on")
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.termguicolors = true

vim.opt.clipboard:append({ "unnamed", "unnamedplus" })
-- vim.opt.clipboard = ""

vim.opt.fileformats = { "unix", "dos" }
vim.g.mapleader = " "
-- laggggggggggg
-- vim.g.clipboard = {
-- 	name = "WslClipboard",
-- copy = {
-- 	["+"] = "win32yank -i --crlf",
-- 	["*"] = "win32yank -i --crlf",
-- },
-- 	paste = {
-- 		["+"] = "win32yank -o --lf",
-- 		["*"] = "win32yank -o --lf",
-- 	},
-- 	cache_enabled = 0,
-- }

-- save on format
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.go", "*.rs", "*.lua" },
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
