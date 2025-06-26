return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
  },
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = { "lua", "python", "c", "bash" },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false
    },
    indent = { enable = true },
    incremental_selection = { enable = true },
    text_objects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner"
        }
      }
    },
    move = {
      enable = true,
      set_jumps = true
    }
  },
  init = function(_)
    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  end
}
