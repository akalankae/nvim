--============================================================================
--                          vim colorschemes
--============================================================================
local colorschemes = {
  -- Theme based on Google's material design
  { "NLKNguyen/papercolor-theme", lazy = false },

  -- dark (charcoal) low-contrast theme (DEFAULT)
  { "bluz71/vim-moonfly-colors" },
  { "ofirgall/ofirkai.nvim" },
  {
    "scottmckendry/cyberdream.nvim",
    config = function()
      vim.cmd [[colorscheme cyberdream]]
    end,
  }, -- high-contrast Cyberpunk vibes!
  {
    "marko-cerovac/material.nvim",
    init = function()
      vim.g.material_style = "deep ocean"
    end,
    opts = {
      high_visibility = {
        lighter = true,
      }
    },
  },
  { "tomasr/molokai" },
}

-- NOTE: all colorschemes should have highest priority (default=50)
vim.tbl_map(
  function(tbl_value)
    tbl_value.priority = 100
  end,
  colorschemes
)

return colorschemes
