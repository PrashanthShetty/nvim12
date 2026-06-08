-- NOTE: npm i -g vscode-langservers-extracted

return {
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	settings = {
		json = {
			validate = { enable = true },
			format = { enable = true }, -- 👈 enable formatting in the server
		},
	},
	on_attach = function(client, bufnr)
		-- ensure the server exposes formatting
		client.server_capabilities.documentFormattingProvider = true

		-- format on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
	end,
}
