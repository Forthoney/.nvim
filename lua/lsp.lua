require("neodev").setup({})

local lspconfig = require("lspconfig")

lspconfig.rubocop.setup({})

vim.opt.signcolumn = "yes"
vim.api.nvim_create_autocmd("FileType", {
    pattern = "ruby",
    callback = function()
        vim.lsp.start({
            name = "rubocop",
            cmd = { "bundle", "exec", "rubocop", "--lsp" },
        })
    end,
})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "ruby",
    callback = function()
        vim.lsp.buf.format()
    end,
})

-- textDocument/diagnostic support until 0.10.0 is released
_timers = {}
local function setup_diagnostics(client, buffer)
    if require("vim.lsp.diagnostic")._enable then
        return
    end

    local diagnostic_handler = function()
        local params = vim.lsp.util.make_text_document_params(buffer)
        client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
            if err then
                local err_msg = string.format("diagnostics error - %s", vim.inspect(err))
                vim.lsp.log.error(err_msg)
            end
            if not result then
                return
            end
            vim.lsp.diagnostic.on_publish_diagnostics(
                nil,
                vim.tbl_extend("keep", params, { diagnostics = result.items }),
                { client_id = client.id }
            )
        end)
    end

    diagnostic_handler() -- to request diagnostics on buffer when first attaching

    vim.api.nvim_buf_attach(buffer, false, {
        on_lines = function()
            if _timers[buffer] then
                vim.fn.timer_stop(_timers[buffer])
            end
            _timers[buffer] = vim.fn.timer_start(200, diagnostic_handler)
        end,
        on_detach = function()
            if _timers[buffer] then
                vim.fn.timer_stop(_timers[buffer])
            end
        end,
    })
end

lspconfig.ruby_ls.setup({
    on_attach = function(client, buffer)
        setup_diagnostics(client, buffer)
    end,
})

-- example to setup lua_ls and enable call snippets
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace",
            },
            workspace = {
                checkThirdParty = false,
            },
        },
    },
})
