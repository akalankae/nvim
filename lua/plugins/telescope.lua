
-- Get fzf loaded and working with telescope
-- require("telescope").load_extension("fzf")

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  keys = {
    { "<leader>fs", require("telescope.builtin").live_grep, desc = "[f]ind [s]tring" },
    { "<leader>ff", require("telescope.builtin").find_files, desc = "[f]ind [f]ile" },
    { "<leader>fb", require("telescope.builtin").buffers, desc = "[f]ind [b]uffer" },
    { "<leader>fh", require("telescope.builtin").help_tags, desc = "[f]ind [h]help tag" },
    { "<leader>fc", require("telescope.builtin").colorscheme, desc = "[f]ind [c]olorscheme" },
    { "<leader>fd", require("telescope.builtin").diagnostics, desc = "[f]ind [d]iagnostic message" },
  },
  -- extensions = { }
  -- config = function(lazyplugin, opts)
  --   require("telescope").load_extension("fzf")
  -- end,
}
