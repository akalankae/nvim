--============================================================================
--                          Telescope Config
--============================================================================
return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "v0.2.0",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    init = function()
      local nnoremap = require("user.util").normal_noremap
      local telescope = require("telescope.builtin")

      nnoremap("<leader>ff", telescope.find_files, { desc = "[f]ind [f]ile" })
      nnoremap("<leader>fh", telescope.help_tags, { desc = "[f]ind [h]elp" })
      nnoremap("<leader>fc", telescope.colorscheme, { desc = "[f]ind [c]olorscheme" })
      nnoremap("<leader>fb", telescope.buffers, { desc = "[f]ind [b]uffer" })
      nnoremap("<leader>fs", telescope.live_grep, { desc = "[f]ind [s]tring" })
      -- Sift through telescope builtin functions (pickers, sorters, ... etc)
      nnoremap("<leader>ft", telescope.builtin, { desc = "[f]ind builtin [t]elescope function" })
      -- Edit neovim config from anywhere
      nnoremap("<leader>en", function()
        telescope.find_files({ cwd = vim.fn.stdpath("config") }) -- ? .themes.get_ivy()
      end, { desc = "[e]dit [n]eovim configuration" })
      nnoremap("<leader>fd", function()
          if telescope.diagnostics then
            telescope.diagnostics()
          else
            vim.notify("Cannot find `telescope.diagnostics()`", vim.log.levels.INFO)
          end
        end,
        { desc = "[f]ind [d]iagnostic msg" })
    end,
    opts = {
      defaults = {
        mappings = {
          i = {
            -- ["<C-h>"] = "which-key",
          },
          n = {
          },
        },
      },
      pickers = {
        find_files = {
          find_command = {
            "fd",
            "--no-ignore", -- do not ignore gitignored files/dirs
          },
          theme = "ivy",   -- TODO: doesn't work for mapping <LEADER>en
        },
      },
    },
  },
}
