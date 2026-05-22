vim.pack.add({
	"https://github.com/akinsho/bufferline.nvim",
})

require("bufferline").setup({
	options = {
		close_command = function(n)
			Snacks.bufdelete(n)
		end,
		right_mouse_command = function(n)
			Snacks.bufdelete(n)
		end,
		diagnostics = "nvim_lsp",
		always_show_bufferline = false,
		separator_style = "thick",
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				text_align = "left",
				separator = true,
			},
			{
				filetype = "snacks_layout_box",
			},
		},
	},
})
