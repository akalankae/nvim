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
      }
    },
  },
}
