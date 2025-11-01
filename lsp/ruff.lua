return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml", "ruff.toml", ".ruff.toml", ".git"
  },
  settings = {
    configurationPreference = "filesystemFirst",
    lineLength = vim.bo.textwidth, -- not working!
  }
}
