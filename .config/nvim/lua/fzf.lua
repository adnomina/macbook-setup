local M = {}

-- Catppuccin Mocha palette
local colors = "--color=bg:#1e1e2e,bg+:#313244,fg:#cdd6f4,fg+:#cdd6f4"
    .. ",hl:#89b4fa,hl+:#89b4fa"
    .. ",prompt:#cba6f7,pointer:#f5c2e7,marker:#f5c2e7"
    .. ",info:#cba6f7,spinner:#f5c2e7,border:#313244,header:#f38ba8"

local function get_root()
    local result = vim.system({ "git", "rev-parse", "--show-toplevel" }, { text = true }):wait()
    if result.code == 0 then
        return vim.trim(result.stdout)
    end
    return vim.fn.getcwd()
end

function M.find_files()
    local root = get_root()
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
        "fd --type f . %s | fzf %s > %s",
        vim.fn.shellescape(root),
        colors,
        vim.fn.shellescape(tmpfile)
    )

    vim.fn.termopen(cmd, {
        cwd = root,
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
                local path = lines[1]
                if not vim.fn.fnamemodify(path, ":p"):find("^/") then
                    path = root .. "/" .. path
                end
                vim.cmd.edit(path)
            end
        end,
    })

    vim.cmd.startinsert()
end

return M
