# MacBook Setup

Automated setup for a fresh macOS (Apple Silicon) development environment. A single script installs all software via Homebrew, symlinks dotfiles via GNU Stow, and configures the shell, terminal, and editors.

## Quick Start

```bash
git clone https://github.com/adnomina/macbook-setup.git
cd macbook-setup
bash setup.sh
```

The script will:

1. Install [Homebrew](https://brew.sh) (if not already installed)
2. Disable Homebrew analytics
3. Install all packages from the `Brewfile`
4. Symlink dotfiles into `$HOME` using [GNU Stow](https://www.gnu.org/software/stow/)
5. Set [Fish](https://fishshell.com) as the default login shell
6. Restart into Fish

> Requires `sudo` access (for adding Fish to `/etc/shells`).

## What Gets Installed

### Packages

| Package | Description |
|---------|-------------|
| `btop` | System resource monitor |
| `coreutils` | GNU core utilities |
| `docker` | Docker CLI |
| `findutils` | GNU find/xargs/locate |
| `fish` | Fish shell |
| `gawk` | GNU awk |
| `gh` | GitHub CLI |
| `git` | Version control |
| `gnu-sed` | GNU sed |
| `gnupg` | GnuPG encryption/signing |
| `jq` | JSON processor |
| `mise` | Polyglot runtime version manager |
| `neovim` (HEAD) | Neovim, built from latest source |
| `ripgrep` | Fast recursive search (`rg`) |
| `starship` | Cross-shell prompt |
| `stow` | Symlink-based dotfile management |
| `tealdeer` | Fast `tldr` client |
| `tmux` | Terminal multiplexer |
| `opencode` | Open-source AI agent (from `anomalyco/tap`) |

### Casks

| Cask | Description |
|------|-------------|
| `claude-code` | Claude AI coding assistant |
| `firefox@developer-edition` | Firefox Developer Edition |
| `font-jetbrains-mono-nerd-font` | JetBrains Mono Nerd Font |
| `ghostty` | Ghostty terminal emulator |
| `obsidian` | Markdown note-taking |
| `zed` | Zed code editor |

## Dotfiles

Dotfiles are organized as [GNU Stow](https://www.gnu.org/software/stow/) packages under `dotfiles/` and symlinked into `$HOME/.config/`:

```
dotfiles/
├── fish/           # Fish shell config + Starship prompt
├── ghostty/        # Ghostty terminal config + Catppuccin theme
├── nvim/           # Neovim config (Lua, native vim.pack + vim.lsp)
└── zed/            # Zed editor settings + keybindings
```

## Theme

[Catppuccin Mocha](https://github.com/catppuccin/catppuccin) is used consistently across Ghostty, Neovim, and Zed.
