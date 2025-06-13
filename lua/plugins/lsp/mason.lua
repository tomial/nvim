return {
	{
		"mason-org/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"gopls",
				"prettier",
				"vue_ls",
				"ts_ls",
				"html",
				"tailwindcss",
			},
		},
		dependencies = {
			"neovim/nvim-lspconfig",
			"mason-org/mason.nvim",
		},
	},
}
