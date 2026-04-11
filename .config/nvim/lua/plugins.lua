vim.pack.add({
    "https://github.com/catppuccin/nvim",
    "https://github.com/folke/which-key.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/romus204/tree-sitter-manager.nvim",
})

require("tree-sitter-manager").setup({
    ensure_installed = {
        "bash", "css", "graphql", "html", "javascript",
        "json", "lua", "nix", "toml", "tsx", "typescript", "yaml",
    },
})

vim.cmd.packadd("nvim.undotree")
vim.cmd.packadd("nvim.difftool")

require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = false,
    term_colors = true,
})

require("which-key").setup({
    preset = "classic",
    spec = {
        {
            mode = { "n", "x" },
            { "gO",  desc = "Document Symbols" },
            { "gra", desc = "Code Action" },
            { "gri", desc = "Goto Implementation" },
            { "grn", desc = "Rename" },
            { "grr", desc = "References" },
            { "grt", desc = "Goto Type Definition" },
            { "grx", desc = "Run Code Lens" },
            { "K",   desc = "Hover" },
        },
    },
})
