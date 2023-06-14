vim.g.mapleader = " "

-- open netrw directory browser
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move visually selected lines up and down respecting indentation
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- when joining lines, keep cursor in place
vim.keymap.set("n", "J", "mzJ`z")

-- when scrolling half screen, keep cursor centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- when searching, keep found string centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- easily copy to system clipboard
vim.keymap.set("n", "<leader>y", [["+y]])
vim.keymap.set("v", "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<C-A-f>", vim.lsp.buf.format)

-- quickfix list navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader><leader>", "<cmd>nohlsearch<CR>") -- clear search highlights
vim.keymap.set("n", "gf", "<cmd>edit <cfile><CR>") -- Allow gf to open non-existent files

-- move vertically by visual line
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk") 

vim.keymap.set("n", "Y", "mz0y$`z") -- Yank the whole line

vim.keymap.set("i", "jj", "<esc>") -- quickly exit insert mode
vim.keymap.set("i", ";;", "<esc>mzA;<esc>`zi") -- quickly insert semicolon at the end of the line
vim.keymap.set("i", ",,", "<esc>mzA,<esc>`zi") -- quickly insert comma at the end of the line

-- keep visual selection after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Maintain cursor position when yanking a visual selection
vim.keymap.set("v", "y", "myy`y")
vim.keymap.set("v", "Y", "myY`y")

-- Quickly save file
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>")

