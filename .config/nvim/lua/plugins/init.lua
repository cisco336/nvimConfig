return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre", -- uncomment for format on save
        opts = require "configs.conform"
    }, -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end
    }, -- test new blink
    {
        import = "nvchad.blink.lazyspec"
    }, {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {"vim", "lua", "vimdoc", "html", "css"}
        }
    }, {
        "floatterminal",
        -- Point `dir` to the top-level folder of your plugin
        dir = vim.fn.expand("~/.config/nvim/lua/local_plugins/floatterminal"),
        lazy = false, -- Load immediately for testing
        config = function()
            -- require("floatterminal") looks in the 'lua' subdir automatically
            require("floatterminal").setup()
        end
    }}
