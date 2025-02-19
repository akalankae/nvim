--============================================================================
--                          Treesitter Config
--============================================================================
-- Source: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- config = require("nvim-treesitter.configs").setup({
    --   ensure_installed = { "lua", "bash", "python", "c" },
    --   sync_install = false,
    --   auto_install = true,
    --   highlight = {
    --     enable = true,
    --   },
    -- }),
    opts = {
      ensure_installed = { "lua", "c", "bash", "python" },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
  },
}
