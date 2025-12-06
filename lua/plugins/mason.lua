--============================================================================
--                          LSP Config
--============================================================================

-- Function to call when `client` (LSP server) attaches to a buffer. i.e.
-- when `LspAttach` event is triggered.
local on_attach = function(client, bufnr)
  if client.name == "ruff" then
    client.server_capabilities.hoverProvider = false
    vim.schedule(function()
      vim.notify("Hover provider capability disabled for " .. client.name, vim.log.levels.INFO)
    end)
  end
end

-- Server settings for each of the installed LSP servers
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
    settings = {
      basedpyright = {
        -- use Ruff's import organizer instead
        disableOrganizedImports = true,
        analysis = {
          typeCheckingMode = "recommended",
        }
      }
    },
    flags = {
      debounce_text_changes = 150,
    }
  },
  -- Needs python-lsp-server, python-lsp-black (arch packages) installed
  -- pylsp = {
  --   settings = {
  --     pylsp = {
  --       plugins = {
  --         pycodestyle = { enabled = false },
  --         yapf = { enabled = false },
  --         autopep8 = { enabled = false },
  --         black = {
  --           enabled = true,
  --           line_length = 80
  --         },
  --       }
  --     }
  --   }
  -- },
  ruff = {
    -- on_attach: `hoverProvider` capability is manually disabled
  },
  -- To make clangd aware of project structure and dependecies it needs
  -- "compile_commands.json" file at root of the project dir. cmake can generate
  -- this with `cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 [dir_of_CMakeLists.txt]`
  clangd = {
    -- cmd = {"clangd", "--background-index", "--clang-tidy", "--log=info"},
    offsetEncoding = "utf-16",
    backgroundIndex = true,
    clangTidy = true,
    log = "info",
    init_options = {
      fallbackFlags = "-std=c99"
    }
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
  },
  gopls = {
    cmd = { "gopls", "serve" }, -- `serve`: run a LSP server for go
    settings = {
      gopls = {
        gofumpt = true, -- enable gofumpt (for formatting)
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        staticcheck = true,
        -- formatting = {
        -- gofumpt = true, -- use gofumpt rules for formatting
        -- goimports = true,
        -- }
      }
    }
  },
}

return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = { "lua_ls", "basedpyright", "clangd" },
  },
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = {
          ui = {
              icons = {
                  package_installed = "✓",
                  package_pending = "➜",
                  package_uninstalled = "✗"
              }
          },
        log_level = vim.log.levels.DEBUG,
      },
    },
    {
      "neovim/nvim-lspconfig",
      config = function()
        vim.diagnostic.config({
          -- Use icons for diganostic signs (instead of letters)
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = " ",
              [vim.diagnostic.severity.WARN] = " ",
              [vim.diagnostic.severity.INFO] = " ",
              [vim.diagnostic.severity.HINT] = " ",
            }
          },
          severity_sort = true,
          update_in_insert = false,
          underline = true,
          virtual_text = {
            source = "if_many", -- if multiple diagnostics
          },
        })
        for server, settings in pairs(server_settings) do
          settings.on_attach = on_attach
          local status_ok, capabilities = pcall(require, "cmp_nvim_lsp")
          if status_ok then
            settings.capabilities = capabilities.default_capabilities()
          else
            vim.notify(capabilities, vim.log.levels.WARN)
          end
          vim.lsp.config(server, settings)
        end
      end,
    },
  },
}
