-- make sure which-key.nvim is installed before running the config
local utils = require("user.util")
local filepath = utils.get_curr_file_path(2) -- STACK LEVEL 2
if not utils.plugin_found(filepath) then
  vim.schedule(function()
    vim.notify("which-key is not installed", vim.log.levels.INFO)
  end)
  return
end

require("which-key").setup({
  opts = {},
  keys = {},
})
