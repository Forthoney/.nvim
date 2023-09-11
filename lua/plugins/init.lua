return {
    "neovim/nvim-lspconfig",

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
