return {
	filetypes = {
		"javascript",
		"typescript",
		"json",
		"vue",
	},
	exclude = { "node_modules" },
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = "in node_modules",
				languages = { "javascript", "typescript", "vue" },
			},
		},
	},
}
