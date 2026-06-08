vim.pack.add({
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("^1"),
	},
})

require("blink.cmp").setup({
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 500,
			window = {
				border = "rounded",
				winblend = 0,
				max_width = math.floor(vim.o.columns * 0.4),
				max_height = math.floor(vim.o.lines * 0.4),
				winhighlight = "Normal:Normal,FloatBorder:Comment,CursorLine:BlinkCmpMenuSelection,Search:None", -- 👈 FloatBorder:Comment for dim gray
			},
			draw = function(opts)
				if opts.item and opts.item.documentation then
					local out = require("pretty_hover.parser").parse(opts.item.documentation.value)
					opts.item.documentation.value = out:string()
				end
				opts.default_implementation(opts)
			end,
		},
		menu = {
			min_width = 62,
			winblend = 0,
			auto_show = function()
				return true
			end,
			draw = {
				-- We don't need label_description now because label and label_description are already
				-- combined together in label by colorful-menu.nvim.
				columns = { { "kind_icon" }, { "label", gap = 1 } },
				components = {
					kind_icon = {
						text = function(ctx)
							return ctx.kind_icon
						end,
						highlight = function(ctx)
							local hl = "BlinkCmpKind" .. ctx.kind
							-- strip background from icon highlight
							vim.api.nvim_set_hl(0, hl .. "Icon", { fg = vim.api.nvim_get_hl(0, { name = hl }).fg, bg = "NONE" })
							return hl .. "Icon"
						end,
					},
					label = {
						text = function(ctx)
							return require("colorful-menu").blink_components_text(ctx)
						end,
						highlight = function(ctx)
							return require("colorful-menu").blink_components_highlight(ctx)
						end,
					},
				},
			},
			border = "rounded",
			winhighlight = "Normal:Normal,FloatBorder:NonText,CursorLine:BlinkCmpMenuSelection,Search:None",
		},
	},
})
-- vim.api.nvim_set_hl(0, "BlinkCmpDocSeparator", { fg = "#555555" })
-- vim.api.nvim_set_hl(0, "BlinkCmpDocSeparator", { link = "BlinkCmpDocBorder" })
-- Lazy load on first insert mode entry
-- local group = vim.api.nvim_create_augroup("BlinkCmpLazyLoad", { clear = true })

-- vim.api.nvim_create_autocmd("InsertEnter", {
-- 	pattern = "*",
-- 	group = group,
-- 	once = true,
-- 	callback = function()
-- 		require("blink.cmp").setup({
-- 			keymap = { preset = "super-tab" },
-- 			appearance = {
-- 				nerd_font_variant = "mono",
-- 				use_nvim_cmp_as_default = true,
-- 			},
-- 			completion = {
-- 				documentation = {
-- 					auto_show = false,
-- 					window = {
-- 						border = "rounded",
-- 						winblend = 0,
-- 						-- Constrain the documentation box to a reasonable size
-- 						max_width = math.floor(vim.o.columns * 0.4),
-- 						max_height = math.floor(vim.o.lines * 0.4),
-- 					},
-- 				},
-- 			},
-- 			sources = {
-- 				default = { "lsp", "path", "snippets", "buffer" },
-- 			},
-- 			fuzzy = { implementation = "prefer_rust_with_warning" },
-- 		})
-- 	end,
-- })
