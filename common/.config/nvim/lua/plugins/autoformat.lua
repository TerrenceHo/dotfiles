return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>a",
				function()
					require("confirm").format({ async = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				bzl = { "buildifier" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				go = { "goimports" },
				javascript = { "prettierd" },
				lua = { "stylua", lsp_format = "fallback" },
				proto = { "clang-format" },
				python = { "black" },
				rust = { "rustfmt" },
				sh = { "shfmt" },
				terraform = { "terraform_fmt" },
			},
			format_on_save = {
				timeout_ms = 1000,
				lsp_format = "fallback",
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		},
	},
}
