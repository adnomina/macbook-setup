# Neovim Configuration

## Overview

A minimal Neovim 0.12 setup using native plugin management (`vim.pack`) and built-in LSP support.

## Plugins

| Plugin | Purpose | Key Features |
|--------|---------|--------------|
| **mason.nvim** | LSP/tool installer | Manages language server installation |
| **catppuccin/nvim** | Color theme | Mocha flavor with true color support |
| **which-key.nvim** | Keybinding helper | Displays available keybindings and descriptions |
| **nvim-web-devicons** | File icons | Icons for different file types in explorer and statusline |
| **lualine.nvim** | Status line | Minimal status/info line at bottom of window |
| **fff.nvim** | Fuzzy file finder | Fast file search with fuzzy matching |
| **nvim-lspconfig** | LSP configurations | Language server protocol client configs |
| **gitsigns.nvim** | Git integration | Git signs in the sign column, hunk navigation and staging |
| **nvim-treesitter** | Syntax highlighting | Tree-sitter based parsing and highlighting |

## Editor Settings

### Display
- **Line numbers**: Relative line numbers with absolute at cursor position
- **Color column**: 80-character guide at column 80
- **Text width**: Wrap at 80 characters
- **Cursor line**: Highlight current line
- **True colors**: Full 24-bit color support
- **Sign column**: Always visible (1-width) for diagnostics and git marks
- **Whitespace**: Visible tab, trailing space, and non-breaking space indicators

### Indentation
- **Type**: Spaces (expandtab)
- **Size**: 4 spaces per tab
- **Smart indent**: Enabled for automatic indentation
- **Shift round**: Round indent to nearest multiple of shiftwidth

### Behavior
- **Search**: Case-insensitive by default, case-sensitive when uppercase is typed (smartcase)
- **Undo persistence**: Undo history saved to `~/.vim/undodir`
- **Clipboard**: Sync with system clipboard (unnamedplus)
- **No swap files**: Swap file creation disabled
- **No mouse**: Mouse support disabled
- **Incremental command**: Live command preview without split
- **Update time**: 300ms (for CursorHold events)
- **Borders**: `winborder = rounded` applied globally; `pumborder = rounded` for completion popup; `pummaxwidth = 80`
- **UI2**: Experimental redesigned message/cmdline UI enabled (eliminates "Press ENTER" prompts)

### File Explorer (netrw)
- **Tree view**: List style with tree hierarchy
- **Window size**: 25% width
- **Splits**: Open files in previous window, new splits to the right
- **No banner**: Hide help banner

## Keyboard Shortcuts

### General

| Keybinding | Mode | Action |
|------------|------|--------|
| `jk` | Insert | Exit insert mode |
| `<Leader>f` | Normal | Format buffer (LSP) |
| `<Leader>d` | Normal | Show diagnostics |
| `<Leader>u` | Normal | Update plugins |
| `<Leader>U` | Normal | Open undo tree |
| `<Leader>e` | Normal | Open file explorer |
| `ff` | Normal | Find files (fff.nvim) |
| `<C-u>` | Normal | Page up (centered) |
| `<C-d>` | Normal | Page down (centered) |
| `<leader>?` | Normal | Show buffer keymaps (which-key) |
| `<C-w><Space>` | Normal | Window hydra mode (which-key) |

### LSP (buffer-local, set on attach)

| Keybinding | Mode | Action |
|------------|------|--------|
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `K` | Normal | Hover documentation |
| `gK` | Normal | Signature help |
| `<leader>cD` | Normal | Workspace diagnostics |

**0.12 built-in defaults (no explicit mapping needed):**

| `gra` | Normal, Visual | Code action |
| `gri` | Normal | Go to implementation |
| `grn` | Normal | Rename symbol |
| `grr` | Normal | References |
| `grt` | Normal | Go to type definition |
| `grx` | Normal | Run code lens |
| `gO` | Normal | Document symbols |
| `<C-s>` | Insert | Signature help |

### Git (gitsigns, buffer-local)

| Keybinding | Mode | Action |
|------------|------|--------|
| `]h` / `[h` | Normal | Next/prev hunk |
| `]H` / `[H` | Normal | Last/first hunk |
| `<leader>ghs` | Normal, Visual | Stage hunk |
| `<leader>ghr` | Normal, Visual | Reset hunk |
| `<leader>ghS` | Normal | Stage buffer |
| `<leader>ghu` | Normal | Undo stage hunk |
| `<leader>ghR` | Normal | Reset buffer |
| `<leader>ghp` | Normal | Preview hunk inline |
| `<leader>ghb` | Normal | Blame line (full) |
| `<leader>ghB` | Normal | Blame buffer |
| `<leader>ghd` | Normal | Diff this |
| `<leader>ghD` | Normal | Diff this (against last commit) |
| `ih` | Operator, Visual | Select hunk (text object) |

**Leader key**: Spacebar (`<Space>`)

## Configuration Details

### LSP

Configured via native `vim.lsp.enable()` and `vim.lsp.config()`.

**Global capabilities** (all servers): workspace file operation notifications (`didRename`, `willRename`)

**Enabled servers:**

| Server | Language |
|--------|----------|
| `bashls` | Bash/Shell |
| `cssls` | CSS |
| `eslint` | JavaScript/TypeScript linting |
| `graphql` | GraphQL |
| `html` | HTML |
| `jsonls` | JSON |
| `lua_ls` | Lua |
| `prismals` | Prisma |
| `sqlls` | SQL |
| `tailwindcss` | Tailwind CSS |
| `vtsls` | TypeScript/JavaScript |

**On attach (per buffer):**
- Inlay hints enabled when supported by the server

### Diagnostics
- Underline enabled, virtual text disabled during insert mode
- Virtual text prefix `●`, spacing 4, source shown when multiple servers
- Severity-sorted with Nerd Font icons in the sign column
- Floating window on `CursorHold` (auto-closes on move/insert)

### Treesitter Languages

Auto-installed on new machines: `javascript`, `typescript`, `tsx`, `css`, `html`, `json`, `graphql`, `lua`, `markdown`, `markdown_inline`

### Completion (native)
- Native `autocomplete` option (0.12 built-in, no plugin required)
- Fuzzy matching (`fuzzy`), documentation popup (`popup`), results sorted by distance to cursor (`nearest`)
- LSP completions via `completionItem/resolve` for documentation side window

### Git (gitsigns.nvim)
- Custom Nerd Font signs: `▎` for add/change/untracked, `` for delete
- Staged changes shown with separate sign set
- Hunk navigation respects diff mode (`]c`/`[c`) vs normal mode
- `ih` text object for selecting hunks in operator/visual mode

### Keybinding Helper (which-key.nvim)
- Helix preset style
- Shows descriptions for all mapped commands with leader key groups labeled
- `<leader>?` to show all buffer-local keymaps
- `<C-w><Space>` for interactive window hydra mode

### fff.nvim
- Lazy sync mode enabled for performance
- Binary auto-downloads on plugin updates

### Visual Enhancements
- **Yank highlighting**: Highlighted text flashes for 150ms when copied
