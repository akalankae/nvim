-- Force using plugin parsers instead of bundled ones
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = { '*.c', '*.cpp','*.h' },
  callback = function()
    print("Treesitter hightlighting is disabled for C/C++ files!")
  end,
})

return {
  "nvim-treesitter/nvim-treesitter",
  enabled = true,
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "lua", "c", "python" },
    auto_install = true, -- install parsers when entering a buffer
    sync_install = true, -- install parsers synchronously
    highlight = {
      enable = true,
      disable = { "c" },
      additional_vim_regex_highlighting = false
    }
  }
}
