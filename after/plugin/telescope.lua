-- make sure telescope is installed before running the config
local utils = require "user.util"
local filepath = utils.get_curr_file_path(2) -- STACK LEVEL 2
if not utils.plugin_found(filepath) then
  vim.schedule(function()
    vim.notify("telescope is not installed", vim.log.levels.INFO)
  end)
  return
end

-- Get fzf loaded and working with telescope
require("telescope").load_extension("fzf")
