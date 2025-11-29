-- Set verbose logging for debugging config
vim.lsp.log.set_level(vim.log.levels.WARN)

vim.lsp.enable({
  "lua_ls", -- Lua
  "clangd", -- C
  "ruff", -- Python
  "ty", -- Python
  "basedpyright", -- Python
  "ts_ls", -- Typescript/Javascript
  "gopls", -- Golang
})

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    }
  },
  virtual_text = {
    severity = {
      min = vim.diagnostic.severity.WARN
    }
  },
  underline = {
    severity = {
      min = vim.diagnostic.severity.ERROR
    }
  },
  severity_sort = true,
})
