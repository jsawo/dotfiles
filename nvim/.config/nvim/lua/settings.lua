vim.cmd('colorscheme rose-pine')
-- vim.cmd('colorscheme dracula')

vim.opt.number = true -- Display absolute line number on the current line only
vim.opt.relativenumber = true -- Use relative line numbers

vim.opt.showmode = false -- hide mode indicator (lualine does that)

vim.opt.tabstop = 4
vim.opt.softtabstop = 4 -- Number of spaces per Tab
vim.opt.shiftwidth = 4 -- Number of auto-indent spaces
vim.opt.expandtab = true -- Insert spaces instead of tabs
vim.opt.smartindent = true -- Insert indents automatically

vim.opt.linebreak = true -- Break lines at word (requires Wrap lines)
vim.opt.showbreak = "→ " -- Wrap-broken line prefix

vim.opt.swapfile = false 
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.updatetime = 50 -- idle time in ms before writing to swap (default 4000)

vim.opt.ignorecase = true -- Search is by default ignores letter case
vim.opt.smartcase = true -- Search is case sensitive only if the pattern has UC letters

vim.opt.hlsearch = true -- Highlight search results
vim.opt.incsearch = true -- Show search results as you type

vim.opt.wildmode = "longest:full,full" -- Completion mode for vim commands

vim.opt.list = true -- show non-printable character
vim.opt.listchars = "tab:▷ ,trail:·,nbsp:␣,extends:❯,precedes:❮" -- which chars to show
vim.opt.termguicolors = true -- Enable 24-bit RGB color

vim.opt.scrolloff = 8 -- Start scrolling before cursor reaches window border
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes" -- leave space for gutter

vim.opt.confirm = true -- Use confirm dialog instead of failing certain commands (like saving)
