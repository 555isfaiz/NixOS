lua << END
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-nvim-dap").setup()

require("mason-lspconfig").setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function (server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {
                capabilities = require("cmp_nvim_lsp").default_capabilities()
              }
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
         ["pyright"] = function ()
            require("lspconfig")["pyright"].setup {
              capabilities = require("cmp_nvim_lsp").default_capabilities();
              settings = {
                  python = {
                    analysis = {
                       typeCheckingMode = 'off'
                      }
                    }
                }
              }
         end,
        ["jdtls"] = function ()
            -- The key is to do nothing here...
         end
    }
END
