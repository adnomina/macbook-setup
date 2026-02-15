local keymap = vim.keymap

keymap.set("i", "jk", "<Esc>")

-- Move up and down and center cursor
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "<C-d>", "<C-d>zz")

-- Format the current buffer using LSP
keymap.set(
    "n",
    "<Leader>fb",
    "<cmd>lua vim.lsp.buf.format()<CR>",
    { desc = "Format file" }
)

-- Show diagnostic
keymap.set(
    "n",
    "<Leader>d",
    "<cmd>lua vim.diagnostic.open_float()<CR>",
    { desc = "Show diagnostics" }
)

-- Go to definition
keymap.set(
    "n",
    "grd",
    "<cmd>lua vim.lsp.buf.definition()<CR>",
    { desc = "Go to definition" }
)

-- Update plugins with vim.pack
keymap.set(
    "n",
    "<Leader>ps",
    "<cmd>lua vim.pack.update()<CR>",
    { desc = "Update plugins" }
)

-- Open the file explorer
keymap.set(
    "n",
    "<Leader>e",
    "<cmd>Lexplore<CR>",
    { desc = "Open file explorer" }
)

keymap.set(
    "n",
    "ff",
    function() require("fff").find_files() end,
    { desc = "FFFind files" }
)
