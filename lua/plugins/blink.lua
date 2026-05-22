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
			},
		},
	},
})

--
-- require("blink.cmp").setup({
-- 	appearance = {
-- 		nerd_font_variant = "mono", -- 'mono' for Nerd Font Mono, 'normal' for Nerd Font
-- 	},
-- 	sources = {
-- 		default = {
-- 			"lsp",
-- 			"path",
-- 			"snippets",
-- 			"buffer",
-- 		},
-- 		providers = {
-- 			lsp = {
-- 				min_keyword_length = 0, -- Number of characters to trigger porvider
-- 				score_offset = 99, -- Boost/penalize the score of the items
-- 			},
-- 			buffer = {
-- 				min_keyword_length = 5,
-- 				max_items = 5,
-- 			},
-- 			path = {
-- 				opts = { get_cwd = vim.uv.cwd },
-- 				min_keyword_length = 0,
-- 			},
-- 			snippets = {
-- 				min_keyword_length = 2,
-- 			},
-- 		},
-- 	},
-- 	cmdline = {
-- 		keymap = {
-- 			-- recommended, as the default keymap will only show and select the next item
-- 			["<Tab>"] = { "show", "accept" },
-- 			["<CR>"] = { "accept_and_enter", "fallback" },
-- 			["<Up>"] = { "select_prev" },
-- 			["<Down>"] = { "select_next" },
-- 			["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
-- 		},
-- 		completion = {
-- 			menu = {
-- 				auto_show = true,
-- 			},
-- 			ghost_text = { enabled = true },
-- 		},
-- 	},
-- 	completion = {
-- 		menu = {
-- 			min_width = 62,
-- 			winblend = 0,
-- 			auto_show = function()
-- 				return true
-- 				-- return vim.fn.getcmdtype() == "."
-- 				-- enable for inputs as well, with:
-- 				-- or vim.fn.getcmdtype() == '@'
-- 			end,
-- 			draw = {
-- 				-- We don't need label_description now because label and label_description are already
-- 				-- combined together in label by colorful-menu.nvim.
-- 				columns = { { "kind_icon" }, { "label", gap = 1 } },
-- 				components = {
-- 					kind_icon = {
-- 						text = function(ctx)
-- 							-- local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
-- 							-- return kind_icon
-- 							return ctx.kind_icon
-- 						end,
-- 						-- (optional) use highlights from mini.icons
-- 						highlight = function(ctx)
-- 							local _, hl, _ = require("nvim-web-devicons").get("lsp", ctx.kind)
-- 							return hl
-- 						end,
-- 					},
-- 					kind = {
-- 						-- (optional) use highlights from mini.icons
-- 						highlight = function(ctx)
-- 							local _, hl, _ = require("nvim-web-devicons").get("lsp", ctx.kind)
-- 							return hl
-- 						end,
-- 					},
-- 					label = {
-- 						text = function(ctx)
-- 							return require("colorful-menu").blink_components_text(ctx)
-- 						end,
-- 						highlight = function(ctx)
-- 							return require("colorful-menu").blink_components_highlight(ctx)
-- 						end,
-- 					},
-- 				},
-- 			},
-- 			border = "rounded",
-- 			winhighlight = "Normal:Normal,FloatBorder:NonText,CursorLine:BlinkCmpMenuSelection,Search:None",
-- 		},
-- 		documentation = {
-- 			auto_show = true,
-- 			auto_show_delay_ms = 200,
-- 			window = {
-- 				border = "rounded",
-- 				winhighlight = "Normal:Normal,FloatBorder:NonText,CursorLine:BlinkCmpDocCursorLine,Search:None",
-- 			},
-- 			draw = function(opts)
-- 				if opts.item and opts.item.documentation then
-- 					local out = require("pretty_hover.parser").parse(opts.item.documentation.value)
-- 					opts.item.documentation.value = out:string()
-- 				end
-- 				opts.default_implementation(opts)
-- 			end,
-- 		},
-- 	},
-- })
--

-- Lazy load on first insert mode entry
local group = vim.api.nvim_create_augroup("BlinkCmpLazyLoad", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*",
	group = group,
	once = true,
	callback = function()
		require("blink.cmp").setup({
			keymap = { preset = "super-tab" },
			appearance = {
				nerd_font_variant = "mono",
				use_nvim_cmp_as_default = true,
			},
			completion = {
				documentation = {
					auto_show = false,
					window = {
						border = "rounded",
						winblend = 0,
						-- Constrain the documentation box to a reasonable size
						max_width = math.floor(vim.o.columns * 0.4),
						max_height = math.floor(vim.o.lines * 0.4),
					},
				},
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		})
	end,
})
