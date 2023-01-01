vim.keymap.set("n", "<C-b>", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<C-A-b>", vim.cmd.NvimTreeFindFile)

require("nvim-tree").setup({
  -- sort_by = "case_sensitive",
  sort_by = "modification_time",
  view = {
    adaptive_size = true,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
