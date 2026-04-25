function lsp_config()
	vim.lsp.enable({ "bashls" })
	vim.lsp.enable({ "bazelrc_lsp" })
	vim.lsp.enable({ "ccls" })
	vim.lsp.enable({ "cmake" })
	vim.lsp.enable({ "gopls" })
	vim.lsp.enable({ "lua_ls" })
	vim.lsp.enable({ "ocamllsp" })
	vim.lsp.enable({ "pyright" })
	vim.lsp.enable({ "ruby_lsp" })
	vim.lsp.enable({ "rust_analyzer" })
	vim.lsp.enable({ "terraformls" })
	vim.lsp.enable({ "vstls" }) -- javascript/typescript
	vim.lsp.enable({ "zls" })

	-- Use LspAttach autocommand to only map the following keys
	-- after the language server attaches to the current buffer
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			-- Buffer local mappings.
			-- See `:help vim.lsp.*` for documentation on any of the below functions
			local opts = { buffer = ev.buf }
			vim.keymap.set("n", "<leader>D", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "<leader>d", function()
				require("fzf-lua").lsp_definitions()
			end, opts)
			vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<leader>H", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
			end, opts)
			vim.keymap.set("n", "<leader>i", function()
				require("fzf-lua").lsp_implementations()
			end, opts)
			vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "<leader>t", function()
				require("fzf-lua").lsp_typedefs()
			end, opts)
			vim.keymap.set("n", "<leader>R", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "<leader>r", function()
				require("fzf-lua").lsp_references()
			end, opts)
			vim.keymap.set("n", "<leader>s", vim.lsp.buf.signature_help, opts)
			vim.keymap.set("n", "<leader>e", function()
				vim.diagnostic.open_float({
					border = "rounded",
					source = true, -- show which linter/LSP produced the diagnostic
					scope = "line", -- 'cursor', 'line', or 'buffer'
				})
			end, { desc = "Show diagnostics" })

			-- configure LSP completion
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			if client and client:supports_method("textDocument/completion") then
				vim.lsp.completion.enable(true, client.id, ev.buf, {
					autotrigger = true,
				})
			end

			-- TODO: configure proper lsp signature popups
		end,
	})
	vim.diagnostic.config({
		virtual_text = true,
		underline = {
			severity = {
				vim.diagnostic.severity.ERROR,
				vim.diagnostic.severity.WARN,
				vim.diagnostic.severity.INFO,
				vim.diagnostic.severity.HINT,
			},
		},
	})
end

function autocmp_config() end

return {
	{
		"neovim/nvim-lspconfig",
		config = lsp_config,
	},
}
