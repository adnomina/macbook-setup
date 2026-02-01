local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight yanked text
local highlight_group = augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({ timeout = 150 })
    end,
    group = highlight_group,
})

-- Show floating diagnostic window on hover
autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, {
            focusable = false,
            scope = "cursor",
            close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
        })
    end,
})

autocmd("PackChanged", {
    callback = function(event)
        if event.data.updated then
            require("fff.download").download_or_build_binary()
        end
    end,
})
