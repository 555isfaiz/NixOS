-- stylue: ignore
local km = vim.keymap.set

km("n", "Q", "@q")

vim.keymap.del("n", "f")
vim.keymap.del("n", "<Tab>")
vim.keymap.del("v", "<Tab>")

-- Telescope
local tb = require("telescope.builtin")
km("n", "fg", tb.current_buffer_fuzzy_find, { desc = "[F]ind in current file using Telescope" })
km("n", "fG", tb.live_grep, { desc = "[F]ind in file using Telescope" })
km("n", "fb", tb.buffers, { desc = "[F]ind buffers using Telescope" })
km("n", "fh", tb.help_tags, { desc = "[F]ind helps using Telescope" })
km("n", "fv", tb.command_history, { desc = "[F]ind command history using Telescope" })
km("n", "fc", tb.commands, { desc = "[F]ind commands using Telescope" })
km("n", "fu", "<cmd>Telescope treesitter default_text=function\\ <cr>", { desc = "[F]ind functions using Telescope" })
km("n", "ft", "<cmd>Telescope treesitter<cr>", { desc = "Inspect treesitter using Telescope" })
km("n", "fm", "<cmd>Telescope treesitter default_text=method\\ <cr>", { desc = "[F]ind methods using Telescope" })
km("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "Find references using Telescope" })
km("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "Find references using Telescope" })
km("n", "<leader>fc", "<nop>")
local opts = { noremap = true, silent = true }
km("v", "fg", function()
    local text = vim.getVisualSelection()
    tb.current_buffer_fuzzy_find({ default_text = text })
end, opts)

km("v", "fG", function()
    local text = vim.getVisualSelection()
    tb.live_grep({ default_text = text })
end, opts)
km(
    "n",
    "ff",
    function() tb.find_files(require("telescope.themes").get_dropdown({ previewer = false })) end,
    { desc = "Telescope [f]ind file" }
)

-- move selected lines
km("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })
km("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })

km("n", "<A-j>", ":m .+1<CR>==", { silent = true })
km("n", "<A-k>", ":m .-2<CR>==", { silent = true })

km("n", "<Tab>", ":>1<CR>", { silent = true })
km("v", "<Tab>", ":'<,'>1><CR>gv", { silent = true })

km({ "n", "v" }, "<C-l>", "$", { noremap = false })
km({ "n", "v" }, "<C-h>", "^", { noremap = false })

-- diagnostics
km("n", "<leader>xx", vim.cmd.TroubleToggle, { desc = "TroubleToggle" })
km("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "TroubleToggle [W]orkspace" })

-- buffers
km({ "n", "i", "v" }, "<A-l>", vim.cmd.bnext, { desc = "Switch to next Buffer" })
km({ "n", "i", "v" }, "<A-h>", vim.cmd.bprev, { desc = "Switch to prev Buffer" })
km("n", "<C-q>", function() vim.cmd("bw") end, { desc = "Close Buffer" })

-- selection
km("n", "<C-a>", "ggVG")

-- paste
km("n", "<leader>p", '"_dP')

-- colors
km("n", "<leader>ct", vim.cmd.ColorizerToggle, { desc = "[C]olorizer" })
km("n", "<leader>cp", vim.cmd.PickColor, { desc = "[P]ick Color" })

-- generate docs
km("n", "<Leader>dg", require("neogen").generate, { desc = "Generate Docs" })

-- tmux
-- km({ "n", "i", "v" }, "<C-h>", vim.cmd.TmuxNavigateLeft)
-- km({ "n", "i", "v" }, "<C-j>", vim.cmd.TmuxNavigateDown)
-- km({ "n", "i", "v" }, "<C-k>", vim.cmd.TmuxNavigateUp)
-- km({ "n", "i", "v" }, "<C-l>", vim.cmd.TmuxNavigateRight)

-- tranparency
km("n", "<leader>o", function()
    vim.cmd("highlight Normal guibg=NONE")
    vim.cmd("highlight NonText guibg=NONE")
    vim.cmd("highlight NonText ctermbg=NONE")
    vim.cmd("highlight NonText ctermbg=NONE")
end)
