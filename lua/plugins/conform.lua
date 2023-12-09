return {
    "stevearc/conform.nvim",
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                ruby = { "rubocop" },
                python = { "black" },
                ocaml = { "ocamlformat" },
                javascript = { "prettier" },
                ["_"] = { "trim_whitespace" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            }
        })
    end,
}
