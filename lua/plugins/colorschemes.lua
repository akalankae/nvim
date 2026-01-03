--============================================================================
--                          vim colorschemes
--============================================================================
return {
  -- Theme based on Google's material design
   "NLKNguyen/papercolor-theme",

  -- high-contrast Cyberpunk vibes!
  {
   "scottmckendry/cyberdream.nvim" ,
    opts = {
      transparent = true, -- make bg darker on kitty
      italic_comments = true,
      highlights = {
        String = { fg = "#5eff6c", bg = "NONE", italic = true },
      }
    }
  }
}
