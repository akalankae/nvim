-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--				lazy.lua
-- 		Configuration file for lazy.nvim plugin manager
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

if not vim.fn.has("nvim-0.8") then
  local major = vim.version().major
  local minor = vim.version().minor
  vim.notify(
    string.format("lazy.nvim requires >= nvim-0.8 (neovim version %d.%d)", major, minor),
    vim.log.levels.WARNING
  )
  return 1
end

-- Clone lazy.nvim from git repo if it is not installed
local lazy_repo = "git@github.com:folke/lazy.nvim"
local lazy_dir = vim.fn.stdpath("data") .. "/lazy"
local lazy_path = vim.fs.joinpath(lazy_dir, vim.fs.basename(lazy_repo))
if not vim.uv.fs_stat(lazy_path) then
  vim.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazy_repo },
    { cwd = lazy_dir })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      {"Failed to clone lazy.nvim:\n", "ErrorMsg"},
      {"\nPress any key to exit..."},
    }, true, { err = true })
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazy_path)

require("lazy").setup({
  spec = {
    { import = "plugins" } -- Import all lua/plugins/*.lua files
  },
  checker = { enabled = true }, -- automatically check for plugin updates
})
