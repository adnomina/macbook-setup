local M = {}

-- Catppuccin Mocha palette
local colors = "--color=bg:#1e1e2e,bg+:#313244,fg:#cdd6f4,fg+:#cdd6f4"
    .. ",hl:#89b4fa,hl+:#89b4fa"
    .. ",prompt:#cba6f7,pointer:#f5c2e7,marker:#f5c2e7"
    .. ",info:#cba6f7,spinner:#f5c2e7,border:#313244,header:#f38ba8"

function M.find_files()
    local tmpfile = vim.fn.tempname()

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal",
        border = "rounded",
    })

    local cmd = string.format(
        "fd --type f . | fzf %s > %s",
        colors,
        vim.fn.shellescape(tmpfile)
    )

    vim.fn.jobstart(cmd, {
        term = true,
        on_exit = function()
            local ok, lines = pcall(vim.fn.readfile, tmpfile)
            vim.fn.delete(tmpfile)
            if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_close(win, true)
            end
            if vim.api.nvim_buf_is_valid(buf) then
                vim.api.nvim_buf_delete(buf, { force = true })
            end
            if ok and #lines > 0 and lines[1] ~= "" then
                vim.cmd.edit(lines[1])
            end
        end,
    })

    vim.cmd.startinsert()
end

return M
