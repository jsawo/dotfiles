local hop = require('hop')
local directions = require('hop.hint').HintDirection

local mapopts = { noremap = true, silent = true }

hop.setup {
    keys = 'etovxqpdygfblzhckisuran',
    quit_key = '<SPC>',
}

vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, {remap=true})

vim.keymap.set('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, {remap=true})

vim.keymap.set('', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, {remap=true})

vim.keymap.set('', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, {remap=true})

vim.keymap.set("n", '<M-;>',   '<cmd>HopWord<cr>', mapopts)
vim.keymap.set("n", '<M-\'>', '<cmd>HopPattern<cr>', mapopts)
