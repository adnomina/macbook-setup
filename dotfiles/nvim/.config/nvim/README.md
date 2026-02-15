# Neovim Configuration

## Overview

A minimal Neovim 0.12 setup using native plugin management (`vim.pack`) and built-in LSP support.

## Plugins

| Plugin | Purpose | Key Features |
|--------|---------|--------------|
| **mason.nvim** | LSP/tool installer | Manages language server installation |
| **blink.cmp** | Completion engine | Rust-based fuzzy completion, LSP/buffer sources, documentation preview |
| **catppuccin/nvim** | Color theme | Mocha flavor with true color support |
| **which-key.nvim** | Keybinding helper | Displays available keybindings and descriptions |
| **nvim-web-devicons** | File icons | Icons for different file types in explorer and statusline |
| **lualine.nvim** | Status line | Minimal status/info line at bottom of window |
| **fff.nvim** | Fuzzy file finder | Fast file search with fuzzy matching |

## Editor Settings

### Display
- **Line numbers**: Relative line numbers with absolute at cursor position
- **Color column**: 80-character guide at column 80
- **Cursor line**: Highlight current line
- **True colors**: Full 24-bit color support
- **Sign column**: Always visible (1-width) for diagnostics and git marks

### Indentation
- **Type**: Spaces (expandtab)
- **Size**: 4 spaces per tab
- **Smart indent**: Enabled for automatic indentation

### Behavior
- **Case-insensitive search**: Ignore case in search patterns
- **Undo persistence**: Undo history saved to `~/.vim/undodir`
- **Clipboard**: Sync with system clipboard (unnamed+)
- **No swap files**: Swap file creation disabled
- **Incremental command**: Live command preview without split

### File Explorer (netrw)
- **Tree view**: List style with tree hierarchy
- **Window size**: 25% width
- **Splits**: Open files in previous window, new splits to the right
- **No banner**: Hide help banner

## Keyboard Shortcuts

| Keybinding | Mode | Action |
|------------|------|--------|
| `jk` | Insert | Exit insert mode |
| `<Leader>fb` | Normal | Format buffer (LSP) |
| `<Leader>d` | Normal | Show diagnostics |
| `<Leader>ps` | Normal | Update plugins |
| `<Leader>e` | Normal | Open file explorer |
| `grd` | Normal | Go to definition (LSP) |
| `ff` | Normal | Find files (fff.nvim) |
| `<C-u>` | Normal | Page up (centered) |
| `<C-d>` | Normal | Page down (centered) |

**Leader key**: Spacebar (`<Space>`)

## Configuration Details

### Completion (blink.cmp)
- Fuzzy matching with Rust implementation for performance
- LSP, path, and buffer sources
- Automatic documentation preview (200ms delay)
- Tab to accept completions or expand snippets
- `<C-b>` / `<C-f>` to scroll documentation
- `<C-k>` to show function signatures

### Keybinding Helper (which-key.nvim)
- Displays available keybindings when you start typing a key sequence
- Shows descriptions for all mapped commands
- Helps discover keyboard shortcuts

### fff.nvim
- Lazy sync mode enabled for performance
- Debug mode with match score display
- Binary auto-downloads on plugin updates

### Floating Diagnostics
- Automatically displayed on cursor hold (CursorHold event)
- Shows LSP diagnostics for current position
- Auto-closes on buffer leave, cursor movement, or insert mode

### Visual Enhancements
- **Yank highlighting**: Highlighted text flashes for 150ms when copied
- **Search highlighting**: Disabled (hlsearch off) for cleaner display

