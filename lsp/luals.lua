return {
  cmd = { "lua-language-server" },
  file_types = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git"
  },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = {
          "lua/?.lua",
          "lua/?/init.lua"
        }
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        library = vim.env.RUNTIME
      }
    }
  }
}
