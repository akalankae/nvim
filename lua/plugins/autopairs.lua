--============================================================================
--                          Auto-pairs Config
--============================================================================
-- Jiangmiao's auto-pairs (written in vimscript) is still the best!
-- source: https://github.com/jiangmiao/auto-pairs
-- NOTE: Because this is a vimscript plugin this does not support lazy loading
return {
  {
    "jiangmiao/auto-pairs",
    lazy = false,
    config = function()
      vim.g.AutoPairsFlyMode = 1
    end,
  },
}
