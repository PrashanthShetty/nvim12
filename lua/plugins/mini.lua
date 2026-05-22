-- Install the plugins (standalone, stable branch)
vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.ai", version = "stable" },
	{ src = "https://github.com/nvim-mini/mini.surround", version = "stable" },
})

-- Configure mini.ai (extended text objects)
require("mini.ai").setup({
	n_lines = 500, -- lines to search around cursor
})

-- Configure mini.surround
require("mini.surround").setup({
	mappings = {
		add = "sa", -- Add surrounding (normal + visual)
		delete = "sd", -- Delete surrounding
		replace = "sr", -- Replace surrounding
		find = "sf", -- Find surrounding (right)
		find_left = "sF", -- Find surrounding (left)
		highlight = "sh", -- Highlight surrounding
		update_n_lines = "sn", -- Update n_lines
	},
})
