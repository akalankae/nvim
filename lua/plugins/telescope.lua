
-- Get fzf loaded and working with telescope
-- require("telescope").load_extension("fzf")

return {
  "nvim-telescope/telescope.nvim",
  tag = "v0.2.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "BurntSushi/ripgrep",
    { "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"
    }
  },
  opts = function(plugin_spec)
    local telescope = require("telescope.builtin")
    local nnoremap = require("user.util").normal_noremap
    nnoremap("<leader>fs", telescope.live_grep, {desc = "[f]ind [s]tring"})
    nnoremap( "<leader>ff", telescope.find_files, {desc = "[f]ind [f]ile"} )
    nnoremap( "<leader>fb", telescope.buffers, {desc = "[f]ind [b]uffer"} )
    nnoremap( "<leader>fh", telescope.help_tags, {desc = "[f]ind [h]help tag"} )
    nnoremap( "<leader>fc", telescope.colorscheme, {desc = "[f]ind [c]olorscheme"} )
    nnoremap( "<leader>fd", telescope.diagnostics, {desc = "[f]ind [d]iagnostic message"} )
  end,
  config = function(lazyplugin, opts)
    require("telescope").load_extension("fzf")
  end,
}
