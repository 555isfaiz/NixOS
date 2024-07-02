nnoremap ff <cmd>Telescope find_files<cr>
nnoremap fg <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap fG <cmd>Telescope live_grep<cr>
nnoremap fb <cmd>Telescope buffers<cr>
nnoremap fh <cmd>Telescope help_tags<cr>
nnoremap fv <cmd>Telescope command_history<cr>
nnoremap fc <cmd>Telescope commands<cr>
nnoremap fu <cmd>Telescope treesitter default_text=function\ <cr>
nnoremap ft <cmd>Telescope treesitter<cr>
nnoremap fm <cmd>Telescope treesitter default_text=method\ <cr>
nnoremap gr <cmd>Telescope lsp_references<cr>
nnoremap gd <cmd>Telescope lsp_definitions<cr>
nnoremap <space>D <cmd>Telescope lsp_type_definitions<cr>

lua << END

function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg('v')
	vim.fn.setreg('v', {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ''
	end
end

local keymap = vim.keymap.set
local tb = require('telescope.builtin')
local opts = { noremap = true, silent = true }

keymap('v', 'fg', function()
	local text = vim.getVisualSelection()
	tb.current_buffer_fuzzy_find({ default_text = text })
end, opts)

keymap('v', 'fG', function()
	local text = vim.getVisualSelection()
	tb.live_grep({ default_text = text })
end, opts)

local telescope = require('telescope')
telescope.setup {
    defaults = {
        vimgrep_arguments = {
        'rg',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--hidden',
        },
    },
    extensions = {
        fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
        }
    },
    pickers = {
        find_files = {
            hidden = true
        }
    }
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('dap')
END
