local venv_path = os.getenv("VIRTUAL_ENV")
local extra_paths = {}

if venv_path then
  table.insert(extra_paths, venv_path .. "/lib/python*/site-packages")
  vim.notify("Using activated virtual environment: " .. venv_path, vim.log.levels.INFO)
else
  venv_path = vim.fn.finddir(".venv", ".;") or vim.fn.finddir("venv", ".;")
  if venv_path ~= "" then
    venv_path = vim.fn.fnamemodify(venv_path, ":p")
    table.insert(extra_paths, venv_path .. "/lib/python*/site-packages")
    vim.notify("Using project virtual environment: " .. venv_path, vim.log.levels.INFO)
  end
end


return {
  cmd = { "jedi-language-server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "pyrightconfig.json", ".git" },
  settings = {
    jedi = {
      completion = {
        disableSnippets = false,
        resolveEagerly = false,
      },
      diagnostics = {
        enable = true,
        didOpen = true,
        didChange = true,
        didSave = true,
      },
      workspace = {
        extraPaths = {}
      }
    }
  }
}
