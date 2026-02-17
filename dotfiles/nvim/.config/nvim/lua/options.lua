local opt = vim.opt

opt.colorcolumn = "80"
opt.textwidth = 80
opt.signcolumn = "yes:1"
opt.termguicolors = true
opt.ignorecase = true
opt.swapfile = false
opt.autoindent = true
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
opt.smartindent = true
opt.list = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.inccommand = "nosplit"
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.completeopt = "fuzzy,menu,menuone,noinsert,popup"
opt.hlsearch = false
opt.clipboard = "unnamedplus"
opt.listchars = "tab:| ,trail:-,nbsp:+"
opt.updatetime = 300

vim.g.mapleader = " "

-- Tree view
vim.g.netrw_liststyle = 3
vim.g.netrw_keepdir = 0
vim.g.netrw_winsize = 25
vim.g.netrw_banner = 0
-- Open files in the previous window
vim.g.netrw_browse_split = 0
-- Open splits to the right
vim.g.netrw_altv = 1

vim.g.fff = {
    lazy_sync = true,
    debug = {
        enabled = true,
        show_scores = true,
    },
}

vim.cmd.filetype("plugin indent on")
vim.cmd.colorscheme("catppuccin")

vim.diagnostic.config({ virtual_text = true })
