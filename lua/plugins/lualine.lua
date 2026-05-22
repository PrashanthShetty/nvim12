vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-lualine/lualine.nvim",
})

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {
				"aerial",
				"NvimTree",
				"starter",
				"Trouble",
				"qf",
				"NeogitStatus",
				"NeogitCommitMessage",
				"NeogitPopup",
			},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
			refresh_time = 16, -- ~60fps
			events = {
				"WinEnter",
				"BufEnter",
				"BufWritePost",
				"SessionLoadPost",
				"FileChangedShellPost",
				"VimResized",
				"Filetype",
				"CursorMoved",
				"CursorMovedI",
				"ModeChanged",
			},
		},
	},
	sections = {
		lualine_a = {
			{
				"mode",
				icon = "",
				fmt = function(str)
					return str:sub(1, 3)
				end,
				color = { gui = "bold" },
			},
		},
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {
		-- lualine_a = {
		-- 	{
		-- 		"buffers",
		-- 		separator = { left = "|", right = "|" },
		-- 		mode = 4,
		-- 	},
		-- },
		-- lualine_c = {},
		-- lualine_b = { "lsp_progress" },
		-- lualine_x = {},
		-- lualine_y = { "grapple" },
		-- lualine_z = { "tabs" },
	},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
