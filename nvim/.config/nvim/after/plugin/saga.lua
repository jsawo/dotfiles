local keymap = vim.keymap.set
local saga = require('lspsaga')
local diag = require("lspsaga.diagnostic")

saga.init_lsp_saga({
    border_style = "single",
    move_in_saga = { prev = '<C-p>',next = '<C-n>'},
    rename_action_quit = '<C-c>',
    finder_action_keys = {
        open = {'o', '<CR>'},
        vsplit = 's',
        split = 'i',
        tabe = 't',
        quit = {'q', '<ESC>'},
    },
    code_action_keys = {
        quit = 'q',
        exec = '<CR>',
    },
    definition_action_keys = {
        edit = 'e',
        vsplit = '<C-c>v',
        split = '<C-c>i',
        tabe = '<C-c>t',
        quit = 'q',
    },
})

-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

-- Code action
keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })

-- Rename
keymap("n", "<F2>", "<cmd>Lspsaga rename<CR>", { silent = true })

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
keymap("n", "sd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

-- Show line diagnostics
keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

-- Show cursor diagnostics
keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

-- Diagnostic jump can use `<c-o>` to jump back
keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

-- Only jump to error
keymap("n", "[D", function() diag.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, { silent = true })
keymap("n", "]D", function() diag.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, { silent = true })

-- Outline
keymap("n","<leader>o", "<cmd>Lspsaga outline<CR>",{ silent = true })

-- Hover Doc
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

-- toggle float terminal
keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
