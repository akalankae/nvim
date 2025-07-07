
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = { "lua", "c", "python" },
    auto_install = true, -- install parsers when entering a buffer
    sync_install = true, -- install parsers synchronously
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false
    }
  }
}
