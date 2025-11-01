vim.lsp.enable({
  "luals",
  "ruff",
  "ty",
  "clangd",
  "basedpyright",
  -- "jedi_language_server",
  "ts_ls",
  "gopls",
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
