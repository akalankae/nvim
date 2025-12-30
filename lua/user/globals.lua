
-- Protected require function
function _G.prequire(module_name)
  local success, module = pcall(require, module_name)
  if not success then
    vim.notify(module, vim.log.levels.ERROR)
    return
  end
  return module
end

-- Global list of plugins
_G.plugins = {}

local plugin_dir = vim.fn.stdpath("data") .. "/lazy"
for node, type in vim.fs.dir(plugin_dir) do
  if type == "directory" then
    table.insert(_G.plugins, node)
  end
end
