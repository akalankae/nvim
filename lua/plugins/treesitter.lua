--============================================================================
--                          Treesitter Config
--============================================================================
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      highlight = { enable = true },

      ensure_installed = { "lua", "bash", "python", "c" },

      additional_vim_regex_highlighting = false,
    })
  end,
}

