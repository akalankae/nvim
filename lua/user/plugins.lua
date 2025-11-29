--==============================================================================
--                      plugin/init.lua
--          Setup plugin manager lazy.nvim and plugins
--==============================================================================
-- Look for the plugin manager (lazy.nvim). If it is not installed clone from github
-- repository to local machine.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
      "git", "clone", "--filter=blob:none", "--branch=stable",
      lazyrepo, lazypath })
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
vim.opt.rtp:prepend(lazypath)

-- `mapleader` and `maplocalleader` have to be setup before this point so that the
-- mappings set up by lazy.nvim are working. This is already setup in user/settings.lua

require("lazy").setup({
  spec = {
    -- build table by joining all tables from all plugins/*.lua files
    { import = "plugins" },

    -- other plugins specs (if any)
  },

  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "wildcharm" } },

  -- automatically check for plugin updates
  checker = { enabled = true },

  -- no plugin lazy-loading by default
  defaults = { lazy = false },

  lockfile = vim.fn.stdpath("data") .. "/.lazy-lock.json",
})
