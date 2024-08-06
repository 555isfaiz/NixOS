lua << END
require('persistence').setup {
  dir = vim.fn.stdpath("state") .. "/sessions/", -- directory where session files are saved
  -- minimum number of file buffers that need to be open to save
  -- Set to 0 to always save
  need = 0,
  branch = true, -- use git branch to save session
}

-- load the session for the current directory
vim.keymap.set("n", "<space>sl", function() require("persistence").load() end)

-- select a session to load
vim.keymap.set("n", "<space>ss", function() require("persistence").select() end)

-- load the last session
vim.keymap.set("n", "<space>so", function() require("persistence").load({ last = true }) end)

-- stop Persistence => session won't be saved on exit
vim.keymap.set("n", "<space>sq", function() require("persistence").stop() end)
END
