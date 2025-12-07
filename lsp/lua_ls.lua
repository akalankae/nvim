return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".emmyrc.json", ".luarc.json", ".luacheckrc", ".stylua.toml", "stylua.toml", ".git" },
  settings = {
    Lua = {
      runtime = {
        version = "Lua 5.4",
      },
      completion = {
        enable = true,
      },
      diagnostics = {
        enable = true,
        globals = { "vim" },
      },
      workspace = {
        library = vim.env.RUNTIME,
        checkThirdParty = false,
      },
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
