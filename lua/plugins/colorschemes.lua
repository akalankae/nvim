-- IMPORTANT: you can CYCLE THROUGH all available colorschemes using custom keymappings
-- <ALT-n> (go to next) and <ALT-p> (go to previous)

return {
  -- Based on Google's material design
  { "NLKNguyen/papercolor-theme",  priority = 1000 },

  -- Futuristic, high-contrast, dark colorscheme
  {
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
}
