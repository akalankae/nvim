return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".emmyrc.json", ".luarc.json", ".luacheckrc", ".stylua.toml", "stylua.toml", ".git" },
  settings = {
    Lua = {
      codeLens = {
        enable = true,
      },
      hint = {
        enable = true,
        semicolon = "Disable",
      },
    },
  },
}

