local mason_lspconfig = require "mason-lspconfig"

local function get_server(name)
  local servers = mason_lspconfig.get_installed_servers()
  if vim.tbl_contains(servers, name) then
    return true, require("lspconfig")[name]
  end
  return false, nil
end

local ok, jdtls = get_server "jdtls"

if not ok then
  vim.notify("mason-lspconfig: jdtls not found, please install it first", vim.log.levels.ERROR)
  return
end

local default_config = jdtls.document_config.default_config
local config = {
  capabilities = require("cmp_nvim_lsp").default_capabilities();
  on_attach = function()
    require("jdtls.setup").add_commands()
    require('jdtls.dap').setup_dap_main_class_configs()
  end,
  cmd = default_config.cmd,
  root_dir = default_config.root_dir(),
  settings = {
    java = {
      format = {
        comments = {
          enabled = false,
        },
        settings = {
          url =
          "https://gist.githubusercontent.com/ikws4/7880fdcb4e3bf4a38999a628d287b1ab/raw/9005c451ed1ff629679d6100e22d63acc805e170/jdtls-formatter-style.xml",
        },
      },
    },
  },
  init_options = {
    bundles = {
      vim.fn.glob(
      "/home/fu1lp0w3r/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-0.47.0.jar",
        1)
    },
  },
}

require("jdtls").start_or_attach(config)
