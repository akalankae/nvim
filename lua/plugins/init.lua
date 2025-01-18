--==============================================================================
--                      plugin/init.lua
--          Setup plugin manager lazy.nvim and plugins
--==============================================================================
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
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
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before loading lazy.nvim 
-- so that mappings are correct.

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    --==========================================================================
    -- COLORSCHEMES
    --==========================================================================
    -- Theme based on Google's material design (DEFAULT)
    { "NLKNguyen/papercolor-theme", lazy = false, priority = 1000 },
    -- A dark charcoal theme
    { "bluz71/vim-moonfly-colors", lazy = false },
    -- Low-contrast dark theme
    { "dasupradyumna/midnight.nvim", lazy = false },

    -- Treesitter
    { "nvim-treesitter/nvim-treesitter", lazy = false, build = ":TSUpdate" },

    -- Autopairs
    { "cohama/lexima.vim", lazy = false },

  },

  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },

  -- automatically check for plugin updates
  checker = { enabled = true },

  defaults = { lazy = true }, -- lazy-load plugins by default
  lockfile = vim.fn.stdpath("data") .. "/.lazy-lock.json",
})
