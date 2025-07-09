return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  opts = {
    options = {
      theme = "auto",
    },
    globalstatus = true, -- single statusline at bottom instead of one for each window
    always_show_tabline = false, -- show tabline only if > 1 tab opened
    sections = {
      lualine_x = { "lsp_status", "encoding", "fileformat", "filetype" }
    }
  }
}
