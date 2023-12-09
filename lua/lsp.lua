require("neodev").setup({})

local lspconfig = require("lspconfig")

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        local nmap = function(keys, func, desc)
            if desc then
                desc = "LSP: " .. desc
            end
            vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = desc })
        end

        nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
        -- See `:help K` for why this keymap
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
        nmap("<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[W]orkspace [L]ist Folders")

        nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    end,
})

-- textDocument/diagnostic support until 0.10.0 is released
local function setup_diagnostics(client, buffer)
    local _timers = {}
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
            local diagnostic_items = {}
            if result then
                diagnostic_items = result.items
            end
            vim.lsp.diagnostic.on_publish_diagnostics(
                nil,
                vim.tbl_extend("keep", params, { diagnostics = diagnostic_items }),
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
-- lspconfig.steep.setup({})
lspconfig.lua_ls.setup({})
lspconfig.ocamllsp.setup({})
lspconfig.pyright.setup({})
lspconfig.tsserver.setup({})
lspconfig.rust_analyzer.setup({})

-- example to setup lua_ls and enable call snippets
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            completion = { callSnippet = "Replace" },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
})
