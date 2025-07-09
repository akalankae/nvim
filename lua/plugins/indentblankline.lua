return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  -- Following comments (begining with ---@) are type annotations for the lua language
  -- server. Unlike python type annotations, lua type annotations are not standardized
  -- by the language. Thus these are comments from POV of lua, but LSP servers can use
  -- them for validation.
  ---@module "ibl"
  ---@type ibl.config
  opts = {},
}
