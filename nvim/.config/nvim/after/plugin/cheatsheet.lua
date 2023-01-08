vim.keymap.set("n", "<leader>?", vim.cmd.Cheatsheet)

require("cheatsheet").setup({
    bundled_cheatsheets = {
        disabled = {
            "unicode",
            "nerd-fonts",
        },
    },
})
