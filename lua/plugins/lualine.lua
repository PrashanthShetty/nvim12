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
		section_separators_color = {
			left = { fg = "#3B4252" }, -- dimmed
			right = { fg = "#3B4252" },
		},
		theme = {
			normal = {
				a = { fg = "#2E3440", bg = "#81A1C1", gui = "bold" },
				b = { fg = "#D8DEE9", bg = "#3B4252" },
				c = { fg = "#D8DEE9", bg = "#2E3440" },
			},
			insert = {
				a = { fg = "#2E3440", bg = "#A3BE8C", gui = "bold" },
			},
			visual = {
				a = { fg = "#2E3440", bg = "#B48EAD", gui = "bold" },
			},
			replace = {
				a = { fg = "#2E3440", bg = "#BF616A", gui = "bold" },
			},
			inactive = {
				a = { fg = "#4C566A", bg = "#2E3440" },
				b = { fg = "#4C566A", bg = "#2E3440" },
				c = { fg = "#4C566A", bg = "#2E3440" },
			},
		},
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
		lualine_c = {
			"filename",
			-- Shows current function/class context
			{
				function()
					local node = vim.treesitter.get_node()
					while node do
						if node:type():match("function") or node:type():match("method") or node:type():match("class") then
							local name_node = node:field("name")[1]
							if name_node then
								return "󰡱 " .. vim.treesitter.get_node_text(name_node, 0)
							end
						end
						node = node:parent()
					end
					return ""
				end,
				color = { fg = "#CBA6F7" },
			},
		},
		lualine_x = {
			{
				function()
					local reg = vim.fn.reg_recording()
					if reg == "" then
						return ""
					end
					return "󰑋 @" .. reg
				end,
				color = { fg = "#F38BA8" },
			},
			{
				function()
					local clients = vim.lsp.get_clients({ bufnr = 0 })
					local ignored = { eslint = true, oxlint = true, biome = true, copilot = true }
					local names = {}
					for _, c in ipairs(clients) do
						if not ignored[c.name] then
							table.insert(names, c.name)
						end
					end
					if #names == 0 then
						return ""
					end
					return "󰒍 " .. table.concat(names, ", ")
				end,
				color = { fg = "#89B4FA" },
			},

			"filetype",
		},
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
