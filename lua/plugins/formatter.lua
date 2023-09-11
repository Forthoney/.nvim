return {
    "mhartington/formatter.nvim",
    config = function()
        require("formatter").setup({
            logging = true,
            log_level = vim.log.levels.WARN,
            filetype = {
                lua = {
                    require("formatter.filetypes.lua").stylua,
                },
                ruby = {
                    require("formatter.filetypes.ruby").rubocop,
                },
                python = {
                    require("formatter.filetypes.python").black,
                },
                ocaml = {
                    require("formatter.filetypes.ocaml").ocamlformat,
                },
                -- Use the special "*" filetype for defining formatter configurations on
                -- any filetype
                ["*"] = {
                    -- "formatter.filetypes.any" defines default configurations for any
                    -- filetype
                    require("formatter.filetypes.any").remove_trailing_whitespace,
                },
            },
        })
    end,
}
