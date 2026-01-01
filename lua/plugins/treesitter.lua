--============================================================================
--                          Treesitter Config
--============================================================================
-- Source: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      {
        "tree-sitter/tree-sitter",
        build = {
          "cargo --install --locked tree-sitter-cli", -- Rust
          "npm install tree-sitter-cli" -- Nodejs
        }
      },
    },
    opts = {
      ensure_installed = { "lua", "bash", "c", "python" },
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
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner"
          },
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
