--=============================================================================
--				init.lua
-- 		Main configuration file for neovim in lua
--=============================================================================

--=============================================================================
--                  SETUP USER LEVEL CONFIGURATION
--=============================================================================
require "user.globals"
require "user.settings"
require "user.keymap"
require "user.autocmd"
require "user.lsp_formatting"

require "user.plugins"
