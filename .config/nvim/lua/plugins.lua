vim.pack.add({
    "https://github.com/catppuccin/nvim",
    "https://github.com/dmtrKovalenko/fff.nvim",
    "https://github.com/folke/which-key.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/nvim-tree/nvim-web-devicons",
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"
    },
})

require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = false,
    term_colors = true,
})

require("gitsigns").setup({
    signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
    },
    signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
    },
    on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
        end

        -- stylua: ignore start
        map("n", "]h", function()
            if vim.wo.diff then
                vim.cmd.normal({ "]c", bang = true })
            else
                gs.nav_hunk("next")
            end
        end, "Next Hunk")
        map("n", "[h", function()
            if vim.wo.diff then
                vim.cmd.normal({ "[c", bang = true })
            else
                gs.nav_hunk("prev")
            end
        end, "Prev Hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
        map({ "n", "x" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "x" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
    end,
})

require("which-key").setup({
    preset = "helix",
    spec = {
        {
            mode = { "n", "x" },
            { "<leader>c",  group = "code" },
            { "<leader>cD", desc = "Workspace Diagnostics" },
            { "<leader>e",  desc = "File explorer" },
            { "<leader>f",  desc = "Format file" },
            { "<leader>d",  desc = "Show diagnostics" },
            { "<leader>u",  desc = "Update plugins" },
            { "<leader>U",  desc = "Undotree" },
            { "<leader>g",  group = "git" },
            { "<leader>gh", group = "hunks" },
            { "[",          group = "prev" },
            { "[d",         desc = "Prev Diagnostic" },
            { "[D",         desc = "Prev Error" },
            { "]",          group = "next" },
            { "]d",         desc = "Next Diagnostic" },
            { "]D",         desc = "Next Error" },
            { "g",          group = "goto" },
            { "gra",        desc = "Code Action" },
            { "gri",        desc = "Goto Implementation" },
            { "grn",        desc = "Rename" },
            { "grr",        desc = "References" },
            { "grt",        desc = "Goto Type Definition" },
            { "grx",        desc = "Run Code Lens" },
            { "gO",         desc = "Document Symbols" },
            { "gx",         desc = "Open with system app" },
            { "z",          group = "fold" },
            { "K",          desc = "Hover" },
            { "<C-W>d",     desc = "Show Diagnostic" },
        },
        {
            mode = "i",
            { "<C-s>", desc = "Signature Help" },
        },
    },
})
