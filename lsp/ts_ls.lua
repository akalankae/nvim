return {
  cmd = { "typescript-language-server", "--stdio" },
  commands = {
  },
  filetypes = { "typescript", "javascript" },
  root_dir = function(bufnr, on_dir)
    local root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
    root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers, { ".git" } }
        or vim.list_extend(root_markers, { ".git" })
    local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()
    on_dir(project_root)
  end,
  init_options = {
    hostInfo = "neovim",
  }
}
