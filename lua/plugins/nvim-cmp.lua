return { -- Autocompletion
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        require("cmp").setup({
            sources = {
                { name = "nvim_lsp" },
            },
        })
    end,
}