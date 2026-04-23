-- Global capabilities for all LSP servers
local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.lsp.config("*", {
    capabilities = capabilities,
})

vim.lsp.enable({
    "bashls",
    "cssls",
    "eslint",
    "graphql",
    "html",
    "jsonls",
    "lua_ls",
    "prismals",
    "tailwindcss",
    "vtsls",
})

vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
    },
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
        },
    },
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local buf = event.buf
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc, silent = true })
        end

        map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
        map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")

        if client then
            -- Inlay hints
            if client:supports_method("textDocument/inlayHint") and vim.bo[buf].buftype == "" then
                vim.lsp.inlay_hint.enable(true, { bufnr = buf })
            end

            -- Completion
            if client:supports_method("textDocument/completion") then
                vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })

                vim.keymap.set("i", "<Tab>", function()
                    if vim.snippet.active({ direction = 1 }) then
                        return "<cmd>lua vim.snippet.jump(1)<cr>"
                    elseif vim.fn.pumvisible() == 1 then
                        return "<C-y>"
                    else
                        return "<Tab>"
                    end
                end, { buffer = buf, expr = true, silent = true, desc = "Confirm completion / next snippet placeholder" })

                vim.keymap.set("i", "<S-Tab>", function()
                    if vim.snippet.active({ direction = -1 }) then
                        return "<cmd>lua vim.snippet.jump(-1)<cr>"
                    elseif vim.fn.pumvisible() == 1 then
                        return "<C-p>"
                    else
                        return "<S-Tab>"
                    end
                end, { buffer = buf, expr = true, silent = true, desc = "Previous completion / previous snippet placeholder" })
            end

            -- Signature help
            if client:supports_method("textDocument/signatureHelp") then
                vim.api.nvim_create_autocmd("CursorHoldI", {
                    buffer = buf,
                    callback = function()
                        vim.lsp.buf.signature_help()
                    end,
                })
            end
        end
    end,
})
