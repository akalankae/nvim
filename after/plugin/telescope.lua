-- This is loaded "after" telescope plugin is laoded

-- Get fzf loaded and working with telescope
require("telescope").load_extension("fzf")

-- Setup telescope
require("telescope").setup()

-- key mappings
local nnoremap = require("user.util").normal_noremap
local telescope = require("telescope.builtin")

nnoremap("<leader>fs", telescope.live_grep, { desc="[f]ind [s]tring" })
nnoremap("<leader>ff", telescope.find_files, { desc="[f]ind [f]ile" })
nnoremap("<leader>fb", telescope.buffers, { desc="[f]ind [b]uffer" })
nnoremap("<leader>fh", telescope.help_tags, { desc="[f]ind [h]elp tag" })
nnoremap("<leader>fc", telescope.colorscheme, { desc="[f]ind [c]olorscheme" })
-- nnoremap("<leader>fd", telescope.diagnostics { desc="[f]ind [d]iagnostic msg" })
