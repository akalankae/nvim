--=============================================================================
--				init.lua
-- 		Main configuration file for neovim in lua
--=============================================================================

require("user.settings")
require("user.keymap")
require("user.autocmd")

require("plugins")
require("plugins.treesitter")
require("plugins.lualine")
