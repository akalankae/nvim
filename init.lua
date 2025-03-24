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
require "user.floatterm"

--=============================================================================
--                  SETUP PLUGIN CONFIGURATION
--=============================================================================
-----------------------------------------
-- Bootstrap plugin manager: lazy.nvim
-----------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyrepo = "https://github.com/folke/lazy.nvim.git"

if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

-- add lazy to runtimepath
vim.opt.rtp:prepend(lazypath)

-----------------------------------------
-- Initialize plugin manager: lazy.nvim
-----------------------------------------
require("lazy").setup({
  -- point to lua/plugins/ dir for plugin specs
  spec = {
    -- List of plugins
    -- Import all plugins from lua/plugins/
    { import = "plugins" },
  }, 

-- Options for lazy.nvim
  defaults = {
    lazy = false,  -- disable lazy-loading by default
  },
  install = { colorscheme = { "darkblue" } }, -- theme when installing plugins
  checker = { enabled = true }, -- automatically check for plugin updates
  lockfile = vim.fn.stdpath("data") .. "/.lazy-lock.json",
  opts = {
    rocks = {
      enabled = false,
      root = vim.fn.stdpath("data") .. "/lazy/lua-rocks",
      hererocks = nil,
    },
  },
  ui = {
    border = "rounded",
    backdrop = 25, -- backdrop opacity [0:opaque, 100:transparent]
    title = "Lazy Management Window",
  },
})
