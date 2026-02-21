vim.pack.add({
    { src = "https://github.com/mason-org/mason.nvim" },
    {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range("^1")
    },
    { src = "https://github.com/catppuccin/nvim" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/dmtrKovalenko/fff.nvim" },
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/lewis6991/gitsigns.nvim"
})

require("mason").setup()

require("blink.cmp").setup({
    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
        }
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    keymap = {
        preset = "default",
        ["<Tab>"] = {
            function(cmp)
                if cmp.snippet_active() then
                    return cmp.accept()
                else
                    return cmp.select_and_accept()
                end
            end,
            "snippet_forward",
            "fallback",
        },
        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
    },
    signature = { enabled = true },
    sources = { default = { "lsp", "path", "buffer" } },
})

require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = false,
    term_colors = true,
})

require("lualine").setup()

require("gitsigns").setup()
