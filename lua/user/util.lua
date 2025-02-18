--==============================================================================
--                      	util.lua
-- 		Utility functions for use by rest of the config
--==============================================================================

local utils = {}
-- Map "lhs" keystrokes to "rhs" keystrokes, non-recurively in normal mode,
-- insert mode and visual mode
function utils.normal_noremap(lhs, rhs, opts)
  opts = vim.tbl_extend("error", { remap = false }, opts or {})
  vim.keymap.set("n", lhs, rhs, opts)
end

function utils.insert_noremap(lhs, rhs, opts)
  opts = vim.tbl_extend("error", { remap = false }, opts or {})
  vim.keymap.set("i", lhs, rhs, opts)
end

function utils.visual_noremap(lhs, rhs, opts)
  opts = vim.tbl_extend("error", { remap = false }, opts or {})
  vim.keymap.set("v", lhs, rhs, opts)
end

return utils
