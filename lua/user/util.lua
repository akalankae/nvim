--==============================================================================
--                      	util.lua
-- 		Utility functions for use by rest of the config
--==============================================================================

local utils = {}
-- Map "lhs" keystrokes to "rhs" keystrokes, non-recurively in normal mode,
-- insert mode and visual mode
function utils.nnoremap(lhs, rhs, opts)
  opts = vim.tbl_extend("error", { remap = false }, opts or {})
  vim.keymap.set("n", lhs, rhs, opts)
end

function utils.inoremap(lhs, rhs, opts)
  opts = vim.tbl_extend("error", { remap = false }, opts or {})
  vim.keymap.set("i", lhs, rhs, opts)
end

function utils.vnoremap(lhs, rhs, opts)
  opts = vim.tbl_extend("error", { remap = false }, opts or {})
  vim.keymap.set("v", lhs, rhs, opts)
end

-- Get absolute path of currently executing block of code.
-- stack_level 0 gets info about `debug.getinfo()` itself
-- stack_level 1 gets info about function calling `getinfo()` (1 stack above)
-- stack_level 2 gets info about any function calling `get_curr_file_path()` (2
-- stacks above)
function utils.get_curr_file_path(stack_level)
  local info = debug.getinfo(stack_level, "S")
  local src = info.source:gsub("^@", "")
  return src
end

-- Search list of plugins to check whether name of config filename matches one
-- of the installed plugins. (returns matched plugin name string)
-- NOTE: needs some "magic" to escape hyphen in file names ("a-b" -> "a%-b")
function utils.plugin_found(config_path)
  local basename = vim.fs.basename(config_path)
  for _, plugin in ipairs(PLUGINS.LIST) do
    if basename:match(vim.pesc(plugin)) then
      return plugin
    end
  end
end

return utils
