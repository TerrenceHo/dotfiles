-- TODO:
-- - autocompletion without C-x C-o
-- - go LSP server
-- - investigate which python lsp server
-- - buffer number:name on status bar
-- - fix fzf? depends on preference
-- - figure out how to modularize my configs
-- - push to github


-- set leader key
vim.g.mapleader = ';'

-- run configs
require("configs.general")
require("configs.lazy")
require("configs.keybindings")
