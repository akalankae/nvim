-- make sure PaperColor theme is installed before running the config
utils = require("user.util")
filepath = utils.get_curr_file_path(2) -- STACK LEVEL 2
if not utils.plugin_found(filepath) then
  vim.notify("papercolor-theme is not installed", vim.log.levels.INFO)
  return
end

vim.cmd("colorscheme PaperColor")
