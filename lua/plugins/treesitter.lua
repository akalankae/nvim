--============================================================================
--                          Treesitter Config
--============================================================================
-- Source: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file
-- Updated (2025-12-30) to work with breaking changes in the main branch
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
  {
     "tree-sitter/tree-sitter",
     build = {
       "cargo install --locked tree-sitter-cli", -- Rust
       "npm install tree-sitter-cli" -- Nodejs
     }
    },
  },
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
    vim.wo[0][0].foldmethod = "expr"
    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
  end,
}
