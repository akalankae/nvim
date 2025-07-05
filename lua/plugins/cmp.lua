local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim"
    },
    opts = function(plugin, opts)
      local cmp = require "cmp"
      local luasnip = require "luasnip"
      opts = opts or {}
      opts.snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end
      }
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" }
      }, {
        { name = "buffer" },
        { name = "path" }
      })
      opts.mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        -- ["<CR>"] = cmp.mapping(function(fallback)
        --   if cmp.visible() then
        --     if luasnip.expandable() then
        --       luasnip.expand()
        --     else
        --       cmp.confirm({ select = false })
        --     end
        --   else
        --     fallback()
        --   end
        -- end),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
      opts.formatting = {
        format = require("lspkind").cmp_format({
          mode = "symbol",
          maxwidth = {
            menu = function() return math.floor(0.5 * vim.o.columns) end,
            abbr = function() return math.floor(0.35 * vim.o.columns) end,
          },
          ellipsis_char = "...",
          show_labelDetails = true,
          -- The function below will be called before any actual modifications from lspkind
          -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
          -- before = function(entry, vim_item)
          --   -- ...
          --   return vim_item
          -- end
        })
      }
      opts.experimental = {
        ghost_text = false, -- not working!
      }
      return opts
    end,
  }
}
