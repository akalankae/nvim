--============================================================================
--                          LSP Config
--============================================================================

-- Refer each server home page to look up available settings
-- NOTE: each of the tables in `server_settings` have `capabilities` and
-- `on_attach` keys that can be used for autocompletion
local server_settings = {
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = {
          enable = true,
          globals = { "vim" },
        },
        workspace = {
          checkThirdParty = false,
          maxPreload = 2000,
          preloadFileSize = 50000,
          library = { vim.env.VIMRUNTIME },
        },
        telemetry = false,
        callSnippet = "Replace",
        format = {
          enable = true,
          defaultConfig = { quote_style = "double", trailing_tab_separator = "smart" },
        },
      },
    },
  },
  -- Alternates: "jedi_language_server", "pylsp", "pyright"
  basedpyright = {
    -- TODO: read the docs of basedpyright and do this!
  },
  -- Needs python-lsp-server, python-lsp-black (arch packages) installed
  pylsp = {
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = { enabled = false },
          yapf = { enabled = false },
          autopep8 = { enabled = false },
          black = {
            enabled = true,
            line_length = 80
          },
        }
      }
    }
  },
  clangd = {
    offsetEncoding = "utf-16"
  },
  bashls = {
    filetypes = { "bash", "sh" }, -- this is default
  },
  -- Odin language serer at https://github.com/DanielGavin/ols.git
  -- I have forked this repo to my account. Running build.sh installs ols on
  -- root of the project. (same for odinfmt.sh for formatting)
  -- `cmd` key points to this executable.
  ols = {
    init_options = {
      checker_args = "-strict-style",
      collections = {
        { name = "shared", path = vim.fn.expand("$HOME/odin-lib") }
      },
    },
    cmd = { vim.fn.expand("$HOME/git/ols/ols") },
    formatting = {
      command = { vim.fn.expand("$HOME/git/ols/odinfmt"), "-stdin" },
    }
  }
}

return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- putting `keys` to this table as a key breaks things so that Lsp<...> commands nvim-lspconfig adds are not loaded
      -- so, ensure keys are mapped before the plugin is loaded
      vim.keymap.set("n", "<Leader>rn", function() vim.lsp.buf.rename() end, { desc = "Rename symbol under cursor" })
    end,
    config = function()
      -- Use icons for diganostic signs (instead of letters)
      local diagnostic_icons = {
        Error = " ",
        Warn  = " ",
        Hint  = " ",
        Info  = " ",
      }
      for type, icon_text in pairs(diagnostic_icons) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon_text, texthl = hl, numhl = hl })
      end
      vim.diagnostic.config({
        signs = true, -- enable signs
        severity_sort = true,
        update_in_insert = false,
        underline = true,
        virtual_text = {
          source = "if_many", -- if multiple diagnostics
        },
      })
      local lspconfig = require "lspconfig"
      for server, settings in pairs(server_settings) do
        lspconfig[server].setup(settings)
      end
    end,
  }
}
