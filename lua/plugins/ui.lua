-- With lazy the plugin will be automatically loaded when it is required somewhere
function evil_line()
	local lualine = require("lualine")

-- Color table for highlights
-- stylua: ignore
local colors = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}

	local conditions = {
		buffer_not_empty = function()
			return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
		end,
		hide_in_width = function()
			return vim.fn.winwidth(0) > 80
		end,
		check_git_workspace = function()
			local filepath = vim.fn.expand("%:p:h")
			local gitdir = vim.fn.finddir(".git", filepath .. ";")
			return gitdir and #gitdir > 0 and #gitdir < #filepath
		end,
	}

	-- Config
	local config = {
		options = {
			-- Disable sections and component separators
			component_separators = "",
			section_separators = "",
			theme = {
				-- We are going to use lualine_c an lualine_x as left and
				-- right section. Both are highlighted by c theme .  So we
				-- are just setting default looks o statusline
				normal = { c = { fg = colors.fg, bg = colors.bg } },
				inactive = { c = { fg = colors.fg, bg = colors.bg } },
			},
		},
		sections = {
			-- these are to remove the defaults
			lualine_a = {},
			lualine_b = {},
			lualine_y = {},
			lualine_z = {},
			-- These will be filled later
			lualine_c = {},
			lualine_x = {},
		},
		inactive_sections = {
			-- these are to remove the defaults
			lualine_a = {},
			lualine_b = {},
			lualine_y = {},
			lualine_z = {},
			lualine_c = {},
			lualine_x = {},
		},
	}

	-- Inserts a component in lualine_c at left section
	local function ins_left(component)
		table.insert(config.sections.lualine_c, component)
	end

	-- Inserts a component in lualine_x at right section
	local function ins_right(component)
		table.insert(config.sections.lualine_x, component)
	end

	ins_left({
		function()
			return "▊"
		end,
		color = { fg = colors.blue }, -- Sets highlighting of component
		padding = { left = 0, right = 1 }, -- We don't need space before this
	})

	ins_left({
		-- mode component
		function()
			return ""
		end,
		color = function()
			-- auto change color according to neovims mode
			local mode_color = {
				n = colors.red,
				i = colors.green,
				v = colors.blue,
				[""] = colors.blue,
				V = colors.blue,
				c = colors.magenta,
				no = colors.red,
				s = colors.orange,
				S = colors.orange,
				[""] = colors.orange,
				ic = colors.yellow,
				R = colors.violet,
				Rv = colors.violet,
				cv = colors.red,
				ce = colors.red,
				r = colors.cyan,
				rm = colors.cyan,
				["r?"] = colors.cyan,
				["!"] = colors.red,
				t = colors.red,
			}
			return { fg = mode_color[vim.fn.mode()] }
		end,
		padding = { right = 1 },
	})

	ins_left({
		-- filesize component
		"filesize",
		cond = conditions.buffer_not_empty,
	})

	ins_left({
		"filename",
		cond = conditions.buffer_not_empty,
		color = { fg = colors.magenta, gui = "bold" },
	})

	ins_left({ "location" })

	ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

	ins_left({
		"diagnostics",
		sources = { "nvim_diagnostic" },
		symbols = { error = " ", warn = " ", info = " " },
		diagnostics_color = {
			error = { fg = colors.red },
			warn = { fg = colors.yellow },
			info = { fg = colors.cyan },
		},
	})

	-- Insert mid section. You can make any number of sections in neovim :)
	-- for lualine it's any number greater then 2
	ins_left({
		function()
			return "%="
		end,
	})

	ins_left({
		-- Lsp server name .
		function()
			local msg = "No Active Lsp"
			local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
			local clients = vim.lsp.get_clients()
			if next(clients) == nil then
				return msg
			end
			for _, client in ipairs(clients) do
				local filetypes = client.config.filetypes
				if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
					return client.name
				end
			end
			return msg
		end,
		icon = " LSP:",
		color = { fg = "#ffffff", gui = "bold" },
	})

	-- Add components to right sections
	ins_right({
		"o:encoding", -- option component same as &encoding in viml
		fmt = string.upper, -- I'm not sure why it's upper case either ;)
		cond = conditions.hide_in_width,
		color = { fg = colors.green, gui = "bold" },
	})

	ins_right({
		"fileformat",
		fmt = string.upper,
		icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
		color = { fg = colors.green, gui = "bold" },
	})

	ins_right({
		"branch",
		icon = "",
		color = { fg = colors.violet, gui = "bold" },
	})

	ins_right({
		"diff",
		-- Is it me or the symbol for modified us really weird
		symbols = { added = " ", modified = "󰝤 ", removed = " " },
		diff_color = {
			added = { fg = colors.green },
			modified = { fg = colors.orange },
			removed = { fg = colors.red },
		},
		cond = conditions.hide_in_width,
	})

	ins_right({
		function()
			return "▊"
		end,
		color = { fg = colors.blue },
		padding = { left = 1 },
	})

	-- Now don't forget to initialize lualine
	lualine.setup(config)
end

return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = evil_line,
	},
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		opts = {
			vim.keymap.set("n", "<leader>fe", ":NvimTreeToggle<CR>", { noremap = true, silent = true }),
			vim.keymap.set("n", "<leader>fE", ":NvimTreeFindFile<CR>", { noremap = true, silent = true }),
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
						},
					},
					view = "mini",
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
		},
	 -- stylua: ignore
	 keys = {
	   { "<leader>sn", "", desc = "+noice"},
	   { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
	   { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
	   { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
	   { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
	   { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
	   { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
	   { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
	   { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
	 },
		config = function(_, opts)
			-- HACK: noice shows messages from before it was enabled,
			-- but this is not ideal when Lazy is installing plugins,
			-- so clear the messages in this case.
			if vim.o.filetype == "lazy" then
				vim.cmd([[messages clear]])
			end
			require("noice").setup(opts)
		end,
	},
	-- {
	-- 	"nvim-telescope/telescope.nvim",
	-- 	opts = {
	-- 		direction = "float",
	-- 		float_opts = {
	-- 			border = "curved",
	-- 		},
	-- 	},
	-- },
	{
		"ibhagwan/fzf-lua",
		opts = {},
		config = function()
			require("fzf-lua").register_ui_select()
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			direction = "float",
			float_opts = {
				border = "curved",
			},
			open_mapping = "<c-t>",
		},
		dependencies = { "echasnovski/mini.icons" },
	},
}
