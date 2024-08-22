lua << END
require('flit').setup {
    keys = { f = 't', F = 'T', t = 'r', T = 'R' },
    -- A string like "nv", "nvo", "o", etc.
    labeled_modes = "v",
    multiline = true,
    -- Like `leap`s similar argument (call-specific overrides).
    -- E.g.: opts = { equivalence_classes = {} }
    opts = {}
}

vim.keymap.set('n',        's', '<Plug>(leap)')
vim.keymap.set('n',        'S', '<Plug>(leap-from-window)')
vim.keymap.set({'x', 'o'}, 's', '<Plug>(leap-forward)')
vim.keymap.set({'x', 'o'}, 'S', '<Plug>(leap-backward)')
vim.keymap.set({'n', 'x', 'o'}, 'ga',  function ()
  require('leap.treesitter').select()
end)

-- Linewise.
vim.keymap.set({'n', 'x', 'o'}, 'gA',
  'V<cmd>lua require("leap.treesitter").select()<cr>'
)


END
