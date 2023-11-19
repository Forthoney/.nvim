return {
    "lukas-reineke/indent-blankline.nvim", -- Add indentation guides even on blank lines
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    config = function()
        require("ibl").setup({
            indent = { char = "┊" },
            whitespace = { remove_blankline_trail = false },
            scope = { enabled = false },
        })
    end,
}
