local status_code, which_key = pcall(require, "which-key")
if not status_code then
  return
end

which_key.setup({
  opts = {},
  keys = {},
})
