--============================================================================
--                          LSP Config
--============================================================================

-- Refer each server home page to look up available settings
-- NOTE: each of the tables in `server_settings` have `capabilities` and 
-- `on_attach` keys that can be used for autocompletion
local server_settings = {
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = {
          enable = true,
          globals = { "vim" },
        },
        workspace = {
          checkThirdParty = false,
          maxPreload = 2000,
          preloadFileSize = 50000,
          library = { vim.env.VIMRUNTIME },
        },
        telemetry = false,
        callSnippet = "Replace",
        format = {
          enable = true,
          defaultConfig = { quote_style = "double", trailing_tab_separator = "smart" },
        },
      },
    },
  },
  -- Alternates: "jedi_language_server", "pylsp", "pyright"
  basedpyright = {
    -- TODO: read the docs of basedpyright and do this!
  },
  clangd = {
    offsetEncoding = "utf-16"
  },
  bashls = {
    filetypes = { "bash", "sh" }, -- this is default
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require "lspconfig"
      for server, settings in pairs(server_settings) do
        lspconfig[server].setup(settings)
      end
    end,
  },
}
