--============================================================================
--                          LSP Config
--============================================================================

local servers = {
  "lua_ls",
  "basedpyright",
  -- "jedi_language_server",
  -- "pylsp",
  "clangd",
}

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require "lspconfig"
      for _, server in ipairs(servers) do
        lspconfig[server].setup( {} )
      end
    end,
  },
}
