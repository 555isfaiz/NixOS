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

require('leap').add_default_mappings()
END
