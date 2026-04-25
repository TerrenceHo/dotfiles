return {
    {
        'ibhagwan/fzf-lua',
        config = function()
            local actions = require("fzf-lua").actions
            require('fzf-lua').setup({
                winopts = {
                    width = 0.8,
                    height = 0.5,
                },
                actions = {
                    files = {
                        ["default"] = actions.file_edit_or_qf,
                        ["ctrl-s"]  = actions.file_split,
                        ["ctrl-v"]  = actions.file_vsplit,
                        ["ctrl-t"]  = actions.file_tabedit,
                        ["alt-q"]   = actions.file_sel_to_qf,
                        ["alt-l"]   = actions.file_sel_to_ll,
                    },
                    buffers = {
                        ["default"] = actions.buf_edit,
                        ["ctrl-s"]  = actions.buf_split,
                        ["ctrl-v"]  = actions.buf_vsplit,
                        ["ctrl-t"]  = actions.buf_tabedit,
                    }
                },
            })
        end
    },
    {
        "numToStr/Comment.nvim",
        lazy = false,
        config = function()
            require("Comment").setup()
        end
    },
    {
        "m4xshen/autoclose.nvim",
        config = function()
            require("autoclose").setup({
                keys = {
                    ["("] = { escape = false, close = true, pair = "()" },
                    ["["] = { escape = false, close = true, pair = "[]" },
                    ["{"] = { escape = false, close = true, pair = "{}" },
                    [">"] = { escape = true, close = false, pair = "<>" },
                    [")"] = { escape = true, close = false, pair = "()" },
                    ["]"] = { escape = true, close = false, pair = "[]" },
                    ["}"] = { escape = true, close = false, pair = "{}" },
                    ['"'] = { escape = true, close = false, pair = '""' },
                    ["'"] = { escape = true, close = false, pair = "''" },
                    ["`"] = { escape = true, close = false, pair = "``" },
                },
            })
        end
    }

}
