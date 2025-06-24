--=============================================================================
--				init.lua
-- 		Main configuration file for neovim in lua
--=============================================================================

-- configurations related to neovim core
require "user.settings"
require "user.keymap"
require "user.autocmd"

-- configurations related to installed plugins
require "plugins"
require "plugins.treesitter"
require "plugins.lualine"
