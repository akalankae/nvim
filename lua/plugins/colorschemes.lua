return {
  { -- Futuristic, high-contrast & vibrant colorscheme
    "scottmckendry/cyberdream.nvim",
    priority = 1000,
    opts = {
      transparent = true, -- make bg darker on kitty
      italic_comments = true,
      highlights = {
        String = { fg = "#5eff6c", bg = "NONE", italic = true },
      }
    }
  },
  { -- Dark charcoal colorscheme
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    priority = 1000,
    init = function(_)
      vim.g.moonflyCursorColor = true
      vim.g.moonflyWinSeparator = 2
    end,
  },
  {
    "Iron-E/nvim-highlite",
    priority = 1000,
  }
}
