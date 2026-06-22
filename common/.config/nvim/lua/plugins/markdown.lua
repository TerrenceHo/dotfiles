return {
	{
		"meanderingprogrammer/render-markdown.nvim",
		ft = { "markdown" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("render-markdown").setup({
				-- Render in normal and visual; raw in insert so editing feels natural
				render_modes = { "n", "v", "c" },

				-- Reveal raw syntax when cursor is on the element (links, etc.)
				anti_conceal = { enabled = true },

				heading = {
					sign = false,
					width = "full",
					-- Plain unicode markers (one per heading level H1–H6)
					-- Replace with Nerd Font glyphs if you have one installed
					-- icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
				},

				code = {
					sign = false,
					-- "block" keeps width tight to content; "full" spans the window
					width = "block",
					right_pad = 1,
					-- Show the language name at the top of the block
					language_name = true,
				},

				bullet = {
					-- Plain unicode bullets per nesting level
					icons = { "●", "○", "◆", "◇" },
				},

				checkbox = {
					unchecked = { icon = "[ ] " },
					checked = { icon = "[x] " },
				},

				-- GitHub-style callout blocks (> [!NOTE] etc.)
				callout = {
					note = { raw = "[!NOTE]", rendered = "Note", highlight = "RenderMarkdownInfo" },
					tip = { raw = "[!TIP]", rendered = "Tip", highlight = "RenderMarkdownSuccess" },
					important = { raw = "[!IMPORTANT]", rendered = "Important", highlight = "RenderMarkdownHint" },
					warning = { raw = "[!WARNING]", rendered = "Warning", highlight = "RenderMarkdownWarn" },
					caution = { raw = "[!CAUTION]", rendered = "Caution", highlight = "RenderMarkdownError" },
				},
			})

			-- -- Toggle between rendered view and raw markdown
			-- vim.keymap.set("n", "<leader>mr", "<cmd>RenderMarkdown toggle<cr>",
			-- 	{ desc = "Toggle markdown rendering" })
		end,
	},
}
