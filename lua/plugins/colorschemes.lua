--============================================================================
--                          vim colorschemes
--============================================================================
return {
  -- Theme based on Google's material design
  { "NLKNguyen/papercolor-theme", lazy = false },

  -- dark (charcoal) low-contrast theme (DEFAULT)
  {
    "bluz71/vim-moonfly-colors", lazy = false,
    config = function()
      vim.cmd [[colorscheme moonfly]]
    end,
  },

  { "ofirgall/ofirkai.nvim" },
  { "scottmckendry/cyberdream.nvim" }, -- high-contrast Cyberpunk vibes!
}
