" This is the bar that shows at the bottom of the active window

lua << END

require('lualine').setup {
	options = {
            globalstatus = true,
			component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            theme = "tokyonight",
			disabled_filetypes = { "neo-tree", "dapui_scopes", "dashboard", "Outline", "dapui_breakpoints", "dapui_stacks", "dapui_watches", "dap-repl", "dapui_console", "aerial"}
		},
	sections = {
		lualine_b = {
            'branch',
            'diff',
			{
				'diagnostics',
				sources = { 'nvim_diagnostic' },
				sections = { 'error', 'warn' },
				symbols = {error = " ", warn = " ", info = " ", hint = "󰌵 " },
				always_visible = true
			}
		},
        lualine_c = {"hostname"},
		lualine_x = {"encoding", "filetype"},
        lualine_y = {"location", "progress"},
        lualine_z = {"windows"}
		}
	}
END
