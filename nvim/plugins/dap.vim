lua << END
require("dapui").setup()

if vim.fn.has('macunix') == 1 then
    require('dap.ext.vscode').load_launchjs(nil, {lldb = {'c', 'cpp'}})
else
    require('dap.ext.vscode').load_launchjs(nil, {cppdbg = {'c', 'cpp'}})
end
require('dap-python').setup('~/.pyvenv/bin/python')

local dap = require('dap')
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/fu1lp0w3r/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
}
dap.adapters.lldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = '/Users/daboyuan/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb',
    args = {"--port", "${port}"},

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}

vim.keymap.set('n', '<F5>', require'dap'.continue)
-- vim.keymap.set('n', '<F17>', require'telescope'.extensions.dap.configurations) -- S-F5
vim.keymap.set('n', '<F6>', require'dap'.terminate)
vim.keymap.set('n', '<F7>', require'dap'.restart)
vim.keymap.set('n', '<F10>', require'dap'.step_over)
vim.keymap.set('n', '<F11>', require'dap'.step_into)
vim.keymap.set('n', 'B', require'dap'.toggle_breakpoint)
vim.keymap.set('n', '<F1>', require'dapui'.toggle)

local dap = require('dap')
local api = vim.api
local keymap_restore = {}
dap.listeners.after['event_initialized']['me'] = function()
  for _, buf in pairs(api.nvim_list_bufs()) do
    local keymaps = api.nvim_buf_get_keymap(buf, 'n')
    for _, keymap in pairs(keymaps) do
      if keymap.lhs == "I" then
        table.insert(keymap_restore, keymap)
        api.nvim_buf_del_keymap(buf, 'n', 'I')
      end
    end
  end
  api.nvim_set_keymap(
    'n', 'I', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
end

dap.listeners.after['event_terminated']['me'] = function()
  for _, keymap in pairs(keymap_restore) do
    api.nvim_buf_set_keymap(
      keymap.buffer,
      keymap.mode,
      keymap.lhs,
      keymap.rhs,
      { silent = keymap.silent == 1 }
    )
  end
  keymap_restore = {}
end
END
