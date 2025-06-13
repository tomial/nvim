-- telescope.nvi
-- local builtin = require("telescope.builtin")
-- vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
-- vim.keymap.set("n", "<leader>fF", builtin.find_files, { desc = "Telescope find files" })
-- vim.keymap.set("n", "<leader>rg", builtin.live_grep, { desc = "Telescope live grep" })
-- vim.keymap.set("n", "<leader>bb", builtin.buffers, { desc = "Telescope buffers" })
-- vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

-- toggleterm
-- vim.keymap.set("n", "<C-t>", ":ToggleTerm<CR>", { silent = true })

-- daily shortcut
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { silent = true })
vim.keymap.set("n", "<leader>N", ":noh<CR>", { silent = true })

-- fzf
vim.keymap.set("n", "<leader>ff", ":FzfLua files<CR>", { silent = true })
-- vim.keymap.set("n", "<leader>fF", ":FzfLua files<CR>", { silent = true })
vim.keymap.set("n", "<leader>rg", ":FzfLua live_grep<CR>", { silent = true })
vim.keymap.set("n", "<leader>bb", ":FzfLua buffers<CR>", { silent = true })
vim.keymap.set("n", "<leader>fh", ":FzfLua helptags<CR>", { silent = true })
vim.keymap.set("n", "<leader>sb", ":FzfLua lines<CR>", { silent = true })
vim.keymap.set("n", "<leader>ca", ":FzfLua lsp_code_actions<CR>", { silent = true })
vim.keymap.set("n", "<leader>fsym", ":FzfLua lsp_live_workspace_symbols<CR>", { silent = true })
vim.keymap.set("n", "<leader>fdef", ":FzfLua lsp_definitions<CR>", { silent = true })
vim.keymap.set("n", "<leader>fimp", ":FzfLua lsp_implementations<CR>", { silent = true })
vim.keymap.set("n", "<leader>fref", ":FzfLua lsp_references<CR>", { silent = true })

-- create format command
vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })
