--==============================================================================
--                      plugin/init.lua
--          Setup plugin manager lazy.nvim and plugins
--==============================================================================
-- Bootstrap lazy.nvim
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

-- Make sure to setup `mapleader` and `maplocalleader` before loading lazy.nvim 
-- so that mappings are correct.

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    ----------------------------------------------------------------------------
    --                      LIST OF PLUGINS
    ----------------------------------------------------------------------------

    --==========================================================================
    -- COLORSCHEMES
    --==========================================================================
    -- NOTE: you can CYCLE-THROUGH all available colorschemes using custom
    -- keymappings <ALT-n> and <ALT-p>

    -- Theme based on Google's material design (DEFAULT)
    { "NLKNguyen/papercolor-theme",  priority = 1000,
            config = function()
                vim.cmd("colorscheme PaperColor")
            end
    },

    { "dasupradyumna/midnight.nvim"  }, -- dark, low-contrast
    { "scottmckendry/cyberdream.nvim" }, -- dark, futuristic, high-contrast
    -- onedark, onelight, onedark_vivid, onedark_dark, vaporwave
    { "olimorris/onedarkpro.nvim", priority = 1000 }, -- Atom: light/dark
    { "bluz71/vim-moonfly-colors", name = "moonfly", priority = 1000 },
    ----------------------------------------------------------------------------

    -- Treesitter
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

    -- Autopairs
    { "cohama/lexima.vim" },

    -- Statusline
    { "nvim-lualine/lualine.nvim",  dependencies = { 
        "nvim-tree/nvim-web-devicons" } },

    -- Telescope for navigation
    { "nvim-telescope/telescope.nvim", branch = "0.1.x",
      dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release" }},
    },

    -- Which key shows key mappings as you type
    { "folke/which-key.nvim", event = "VeryLazy" },
    ----------------------------------------------------------------------------
    -- end list of plugins
    ----------------------------------------------------------------------------

  },

  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },

  -- automatically check for plugin updates
  checker = { enabled = true },

  defaults = { lazy = false }, -- do not lazy-load plugins by default
  lockfile = vim.fn.stdpath("data") .. "/.lazy-lock.json",
})
