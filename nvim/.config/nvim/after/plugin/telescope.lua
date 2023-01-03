local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local trouble = require("trouble.providers.telescope")

vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>F', function() builtin.find_files({ no_ignore = true, prompt_title = 'All Files' }) end, {})
vim.keymap.set('n', '<leader>h', function() builtin.oldfiles({ prompt_title = 'Recent Files' }) end, {})
vim.keymap.set('n', '<leader>s', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>gr', builtin.live_grep, {})
vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
map("n", "<leader>b", ":Telescope file_browser<cr>", opts)

telescope.setup{
  defaults = {
    prompt_prefix = '   ',
    selection_caret = '» ',
    layout_config = {
      prompt_position = 'top',
    },
    sorting_strategy = 'ascending',
    mappings = {
      i = {
        ['<esc>'] = actions.close,
        ['<C-Down>'] = actions.cycle_history_next,
        ['<C-Up>'] = actions.cycle_history_prev,
        ["<c-t>"] = trouble.open_with_trouble,
      },
      n = {
        ["<c-t>"] = trouble.open_with_trouble,
      }
    },
    file_ignore_patterns = { '.git/' },
  },
  pickers = {
    find_files = {
      theme = "dropdown",
			hidden = true,
    },
    live_grep = {
      theme = "dropdown",
      layout_config = {
        width = 100,
      },
    },
    buffers = {
      previewer = false,
      layout_config = {
        width = 80,
      },
    },
    oldfiles = {
      prompt_title = 'History',
    },
    lsp_references = {
      previewer = false,
    },
  },
  extensions = {
    file_browser = {
      hijack_netrw = true, -- use this instead of netrw
    },
  },
}

telescope.load_extension "file_browser"
