vim.pack.add({
	"https://github.com/folke/flash.nvim",
})

local flash = require("flash")
flash.setup({
	modes = {
		-- options used when flash is activated through
		-- `f`, `F`, `t`, `T`, `;` and `,` motions
		char = {
			keys = { "f", "F", "t", "T", ",", ";" },
			enabled = true,
			-- show jump labels
			jump_labels = true,
		},
	},
})

-- stylua: ignore start
vim.keymap.set({"n","x","o"}, "gs", function() flash.jump() end, { desc = "Flash" })
vim.keymap.set({"n","x","o"}, "gS", function() flash.treesitter() end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function() flash.remote() end, { desc = "Flash Remote" })
vim.keymap.set({"x","o"}, "R", function() flash.treesitter_search() end, { desc = "Flash Treesitter Search" })
vim.keymap.set("c", "<c-s>", function() flash.toggle() end, { desc = "Toggle Flash search" })
-- stylua: ignore end
