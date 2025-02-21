-- some global variables

local plugin_mgr = "lazy" -- TODO/IDEA: ? configurable plugin manager

-- NOTE: contains the list of plugins at start up time, during session new
-- plugins maybe installed and previous plugins maybe uninstalled, but this list
-- remains the same.
PLUGINS = {
  DIR = vim.fs.joinpath(vim.fn.stdpath("data"), plugin_mgr),
  LIST = {},
}

for name, type in vim.fs.dir(PLUGINS.DIR) do
  if type == "directory" then
    table.insert(PLUGINS.LIST, name)
  end
end
