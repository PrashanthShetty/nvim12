vim.pack.add({
	{ src = "https://github.com/mfussenegger/nvim-dap", version = "stable" },
	{ src = "https://github.com/rcarriga/nvim-dap-ui", version = "stable" },
	{ src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
	{ src = "https://github.com/nvim-neotest/nvim-nio", version = "stable" }, -- required by dap-ui
	{ src = "https://github.com/leoluz/nvim-dap-go", version = "main" },
	{ src = "https://github.com/mfussenegger/nvim-dap-python", version = "master" },
	{ src = "https://github.com/Weissle/persistent-breakpoints.nvim" },
})

require("persistent-breakpoints").setup({
	load_breakpoints_event = { "BufReadPost" },
})

require("nvim-dap-virtual-text").setup({
	virt_text_pos = "eol",
})

local dap = require("dap")
local dapui = require("dapui")

-- Go
require("dap-go").setup()

-- Python
require("dap-python").setup("python3") -- or full path to your venv python

-- TypeScript / Node
dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "js-debug-adapter",
		args = { "${port}" },
	},
}
dap.configurations.typescript = {
	{
		type = "pwa-node",
		request = "launch",
		name = "Launch TS file",
		runtimeExecutable = "npx",
		runtimeArgs = { "ts-node", "${file}" },
		sourceMaps = true,
		cwd = "${workspaceFolder}",
	},
}
dap.configurations.javascript = dap.configurations.typescript

dapui.setup({
	floating = { border = "rounded" },
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.4 },
				{ id = "breakpoints", size = 0.2 },
				{ id = "stacks", size = 0.2 },
				{ id = "watches", size = 0.2 },
			},
			size = 40,
			position = "left",
		},
		{
			elements = {
				{ id = "repl", size = 0.5 },
				{ id = "console", size = 0.5 },
			},
			size = 10,
			position = "bottom",
		},
	},
})

-- auto open/close dapui when debugging starts/ends
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

local map = vim.keymap.set

map(
	"n",
	"<leader>db",
	"<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>",
	{ desc = "Toggle breakpoint" }
)
map("n", "<leader>dc", dap.continue, { desc = "Continue" })
map("n", "<leader>dn", dap.step_over, { desc = "Step over" })
map("n", "<leader>di", dap.step_into, { desc = "Step into" })
map("n", "<leader>do", dap.step_out, { desc = "Step out" })
map("n", "<leader>dt", dapui.toggle, { desc = "Toggle debug UI" })
map("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
map("n", "<leader>dx", dap.terminate, { desc = "Terminate" })

map("n", "<F5>", dap.continue, { desc = "Debug: Start / Continue" })
map("n", "<F4>", dap.terminate, { desc = "Debug: Stop" })
map("n", "<F10>", dap.step_over, { desc = "Debug: Step over" })
map("n", "<F11>", dap.step_into, { desc = "Debug: Step into" })
map("n", "<F12>", dap.step_out, { desc = "Debug: Step out" })
map(
	"n",
	"<F9>",
	"<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>",
	{ desc = "Debug: Toggle breakpoint" }
)
map("n", "<F7>", dapui.toggle, { desc = "Debug: Toggle UI" })
