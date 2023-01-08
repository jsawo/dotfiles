-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use('wbthomason/packer.nvim')

    -- colorschemes
    use({'rose-pine/neovim', as = 'rose-pine'})
    use('Mofiqul/dracula.nvim')
    use('projekt0n/github-nvim-theme')

    use({'nvim-lualine/lualine.nvim', requires = { 
        { 'kyazdani42/nvim-web-devicons', opt = true },
    }})

    -- Telescope - fuzzy finder
    use({'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { 
        { 'nvim-lua/plenary.nvim' },
    }})
    use('nvim-telescope/telescope-file-browser.nvim')

    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'}) -- Treesitter - syntax highlighting
    use('nvim-treesitter/playground') -- Show treesitter AST
    use('theprimeagen/harpoon') -- Harpoon - quick file navigation
    use('mbbill/undotree') -- Undotree - undo history visualized
    use('folke/zen-mode.nvim') -- ZenMode - distraction free writing
    use('folke/twilight.nvim') -- Twilight - dim inactive code in zen mode
    use('nvim-treesitter/nvim-treesitter-context') -- Treesitter Context - show context around cursor
    use({'glepnir/lspsaga.nvim', branch = 'main'}) -- LSP Saga - LSP UI
    use('numToStr/Comment.nvim') -- Comment - comment/uncomment code
    use('danilamihailov/beacon.nvim') -- Beacon - highlight cursor line
    use({'karb94/neoscroll.nvim', config = function() require('neoscroll').setup() end}) -- smooth scrolling
    use({'ray-x/lsp_signature.nvim', config = function() require('lsp_signature').setup({}) end}) -- show function signature
    use('monaqa/dial.nvim') -- Dial - increment/decrement numbers
    use({'folke/trouble.nvim', requires = { -- list diagnostics
        { 'kyazdani42/nvim-web-devicons' } 
    }}) 

    -- CheatSheet - handy keyboard shortcuts
    use({'sudormrfbin/cheatsheet.nvim', requires = {
        { 'nvim-telescope/telescope.nvim' },
        { 'nvim-lua/popup.nvim' },
        { 'nvim-lua/plenary.nvim' },
    }})

    -- neo-tree - file explorer
    use({'nvim-neo-tree/neo-tree.nvim', branch = 'v2.x', requires = { 
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-tree/nvim-web-devicons' },
        { 'MunifTanjim/nui.nvim' },
    }})

    use('nvim-tree/nvim-web-devicons') -- NERD Icons support
    use({'romgrk/barbar.nvim', wants = 'nvim-web-devicons'}) -- buffer tab bar
    use({"ziontee113/color-picker.nvim", config = function() require("color-picker") end}) -- color picker
    use('mg979/vim-visual-multi') -- visual multi cursor
    use('RRethy/nvim-treesitter-textsubjects') -- text subjects for treesitter
    use('nvim-treesitter/nvim-treesitter-textobjects') -- text objects for treesitter

    -- Indent Tools
    use({"arsham/indent-tools.nvim", requires = { "arsham/arshlib.nvim" },
        config = function() require("indent-tools").config({}) end,
    })

    -- LSP stuff
    use({'VonHeikemen/lsp-zero.nvim', requires = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },
        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
    }})

    use('github/copilot.vim') -- copilot
end)

