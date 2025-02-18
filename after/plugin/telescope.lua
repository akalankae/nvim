-- make sure telescope is installed before running the config
utils = require("user.util")
filepath = utils.get_curr_file_path(2) -- STACK LEVEL 2
if not utils.plugin_found(filepath) then
  vim.schedule(function()
    vim.notify("telescope is not installed", vim.log.levels.INFO)
  end)
  return
end

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
