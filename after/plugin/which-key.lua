-- make sure which-key.nvim is installed before running the config
utils = require("user.util")
filepath = utils.get_curr_file_path(2) -- STACK LEVEL 2
if not utils.plugin_found(filepath) then
  vim.notify("which-key is not installed", vim.log.levels.INFO)
  return
end

require("which-key").setup({
  opts = {},
  keys = {},
})
