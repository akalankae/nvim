--============================================================================
--                          Treesitter Config
--============================================================================
-- Source: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = { "lua", "c", "bash", "python" },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
      },
      text_objects = {
        select = {
          enable = true,
          lookahead = true,
        },
      },
      move = {
        enable = true,
        set_jumps = true,
      },
    },
    init = function(_)
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end,
  },
}
