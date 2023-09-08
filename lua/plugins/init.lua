return {
    { -- LSP Configuration & Plugins
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            -- Additional lua configuration, makes nvim stuff amazing
            "folke/neodev.nvim",
        },
    },

    { -- Autocompletion
        "hrsh7th/nvim-cmp",
        dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
    },

    "mfussenegger/nvim-lint",

    -- Git related plugins
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",

    "rose-pine/neovim",
    "numToStr/Comment.nvim", -- "gc" to comment visual regions/lines
    "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
}
