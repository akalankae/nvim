--============================================================================
--                          Telescope Config
--============================================================================
return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local builtin = require "telescope.builtin"
      local map = function(lhs, rhs, opts)
        vim.keymap.set("n", lhs, rhs, opts)
      end
      map("<leader>ff", builtin.find_files, { desc = "[f]ind [f]ile" })
      map("<leader>fh", builtin.help_tags, { desc = "[f]ind [h]elp" })
      map("<leader>fc", builtin.colorscheme, { desc = "[f]ind [c]olorscheme" })
      map("<leader>fs", builtin.live_grep, { desc = "[f]ind [s]tring" })
      -- Sift through telescope builtin functions (pickers, sorters, ... etc)
      map("<leader>lb", builtin.builtin, { desc = "[l]ookup [b]uiltin telescope functions" })
      -- Edit neovim config from anywhere
      map("<leader>en", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") }) -- ? .themes.get_ivy()
      end, { desc = "[e]dit [n]eovim configuration" })
    end,
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-h>"] = "which-key",
          },
          n = {
          },
        },
      },
      pickers = {
        find_files = { theme = "ivy" }, -- TODO: doesn't work for mapping <LEADER>en
      },
    },
  },
}
