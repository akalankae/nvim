-- configuration for LSP servers

local function has_words_before()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function feedkey(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")


mason_lspconfig.setup({
  -- List of LSP servers
  ensure_installed = { "lua_ls" },
})

mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      on_attach = function(client, buffer)
        vim.notify(vim.inspect(client.server_capabilities))
        vim.notify(client.name .. " is attached to buffer " .. buffer)
      end,
    })
  end,
  ["lua_ls"] = function()
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          runtime = { version = "LuaJIT", path = vim.split(package.path, ";"), },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    })
  end,
})

local cmp = require("cmp")
local luasnip = require("luasnip")
local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
    ["<C-n>"] = cmp.mapping.select_next_item(select_opts),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    -- jump to next placeholder in snippet
    ["<C-j>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump()
      else
        fallback()
        vim.notify("Cannot jump next placeholder", vim.log.levels.WARN, { title = "Auto Completions" })
      end
    end, { "i", "s" }),
    -- jump to previous placeholder in snippet
    ["<C-k>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
        vim.notify("Cannot jump to previous placeholder", vim.log.levels.WARN, { title = "Auto Completions" })
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lua" },
    { name = "luasnip",  option = { use_show_condition = true, show_autosnippets = true } },
    { name = "nvim_lsp", keyword_length = 5 },
    { name = "buffer" },
    { name = "path" },
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  experimental = { ghost_text = true },
})

-- Customize diagnostic signs
local signs = { Error = "\u{26D4}", Warn = "\u{26A0}", Hint = "\u{1F4A1}", Info = "\u{2139}" }

for _type, _icon in pairs(signs) do
  local hl = "DiagnosticSign" .. _type
  vim.fn.sign_define(hl, { text = _icon, texthl = hl, numhl = "" })
end

-- Customize diagnostic display settings
-- vim.diagnostic.config({
--   virtual_text = {
--     prefix = "●", -- Could also use '■', '▎', '▏', etc.
--   },
--   signs = true,
--   underline = true,
--   update_in_insert = false,
--   severity_sort = true,
-- })
--
