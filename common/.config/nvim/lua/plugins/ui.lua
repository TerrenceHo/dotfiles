return {
	{
		"monsonjeremy/onedark.nvim",
		priority = 1000,
		branch = "treesitter",
		config = function()
			require("onedark").setup({
				diagnostics = {
					darker = false,
				},
			})
			require("onedark").load()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					-- theme = "onedark",
					icons_enabled = false,
					section_separators = "",
					component_separators = "",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = {
						{
							"buffers",
							mode = 4, --[[ buffer name + buffer index ]]
							buffers_color = {
								inactive = "lualine_c_inactive", -- Color for active buffer.
								active = "lualine_a_inactive", -- Color for inactive buffer.
							},
						},
					},
					lualine_c = {},
					lualine_x = { "encoding", "fileformat", "filetype" },
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
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main", -- just being explicit
		build = ":TSUpdate",
		lazy = false,
		config = function()
			local ensure_installed = {
				"c",
				"comment",
				"cpp",
				"css",
				"diff",
				"dockerfile",
				"gitcommit",
				"git_config",
				"gitignore",
				"go",
				"gomod",
				"gosum",
				"haskell",
				"hcl",
				"html",
				"javascript",
				"lua",
				"make",
				"ocaml",
				"ocaml_interface",
				"ocamllex",
				"proto",
				"python",
				"requirements",
				"rust",
				"starlark",
				"terraform",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
				"zsh",
			}

			-- 1) Install parsers
			local installed = require("nvim-treesitter.config").get_installed()
			local to_install = vim.iter(ensure_installed)
				:filter(function(lang)
					return not vim.tbl_contains(installed, lang)
				end)
				:totable()
			if #to_install > 0 then
				require("nvim-treesitter").install(to_install)
			end

			-- 2) Enablie highlightinga nd indentation
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start) -- highlighting

					local ft = vim.bo.filetype
					-- exceptions for indentation
					-- if ft ~= "c" and ft ~= "cpp" then
					-- 	vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					-- end

					-- treesitter based folding
					vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo[0][0].foldmethod = "expr"
					vim.wo[0][0].foldlevel = 99 -- start with everything unfolded
				end,
			})
		end,
	},
}
