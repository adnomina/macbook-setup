# MacBook Setup

Automated setup for a fresh macOS (Apple Silicon) development environment. Packages are managed via [Nix](https://nixos.org) and [nix-darwin](https://github.com/nix-darwin/nix-darwin), with dotfiles symlinked via [GNU Stow](https://www.gnu.org/software/stow/).

## Quick Start

**1. Install Nix** (if not already installed):

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

**2. Apply the Nix configuration** (installs all packages, symlinks dotfiles, and sets Fish as default shell):

```bash
git clone https://github.com/adnomina/macbook-setup.git
cd macbook-setup
sudo darwin-rebuild switch --flake .
```

## What Gets Installed

Packages are declared in `flake.nix`. Nix manages most software; Homebrew is used only for packages unavailable in nixpkgs.

### Nix Packages

| Package | Description |
|---------|-------------|
| `bat` | Cat clone with syntax highlighting |
| `btop` | Resource monitor |
| `claude-code` | Claude Code CLI |
| `colima` | Container runtime for macOS |
| `coreutils` | GNU core utilities |
| `docker` / `docker-compose` | Container tooling |
| `gh` | GitHub CLI |
| `git` | Version control |
| `gnupg` | GNU Privacy Guard |
| `jq` | JSON processor |
| `mise` | Polyglot runtime version manager |
| `neovim` (nightly) | Text editor (via [neovim-nightly-overlay](https://github.com/nix-community/neovim-nightly-overlay)) |
| `nerd-fonts.jetbrains-mono` | JetBrains Mono Nerd Font |
| `nil` | Nix language server |
| `obsidian` | Markdown note-taking |
| `opencode` | OpenCode CLI |
| `postgresql_18` | PostgreSQL 18 |
| `ripgrep` | Fast regex search |
| `slack` | Team messaging |
| `starship` | Cross-shell prompt |
| `stow` | Symlink farm manager |
| `tealdeer` | tldr pages client |
| `tree-sitter` | Parser generator + CLI |
| `yazi` | Terminal file manager |
| `zed-editor` | Zed code editor |

### Homebrew Casks (via nix-homebrew)

| Cask | Description |
|------|-------------|
| `aerospace` | Tiling window manager (from `nikitabobko/tap`) |
| `arc` | Arc browser |
| `beekeeper-studio` | SQL editor and database manager |
| `firefox@developer-edition` | Firefox Developer Edition |
| `ghostty` | Ghostty terminal emulator |
| `karabiner-elements` | Keyboard remapper |
| `yaak` | API client |

## Updating

To update all nix inputs and rebuild, run the following two commands in the root of this repository.

```bash
nix flake update
darwin-rebuild switch --flake .
```

## Dotfiles

Dotfiles are organized as [GNU Stow](https://www.gnu.org/software/stow/) packages under `dotfiles/` and symlinked into `$HOME`:

```
dotfiles/
├── aerospace/      # AeroSpace tiling window manager config (cmd as modifier)
├── fish/           # Fish shell config
├── ghostty/        # Ghostty terminal config + Catppuccin theme
├── karabiner/      # Karabiner-Elements: caps lock → ctrl
├── nvim/           # Neovim config (Lua, native vim.pack + vim.lsp)
├── starship/       # Starship prompt config
├── tuna/           # Tuna launcher config (leader mode bindings)
├── wezterm/        # WezTerm terminal emulator config
└── zed/            # Zed editor settings + keybindings
```

### Tuna Leader Mode

Leader key: tap right `⌘`.

| Key | Action |
|-----|--------|
| `s` | Safari |
| `t` | Terminal |
| `f` | Finder |
| `m` | Messages |
| `n` | Notes |
| `d` | Downloads folder |
| `h` | Home folder |
| `w` | **Aerospace** (submenu) |

#### Aerospace submenu (`w → …`)

| Key | Action |
|-----|--------|
| `1` / `2` / `3` | Switch to workspace 💬 / 🌐 / 💻 |
| `f` | Fullscreen |
| `F` | Flatten workspace tree |
| `s` | Enter resize mode |
| `R` | Reload AeroSpace config |
| `l → h/v` | Layout h_accordion / v_accordion |
| `l → t` | Layout tiles |
| `l → f` | Toggle floating/tiling |
| `j → h/j/k/l` | Join with left/down/up/right |
| `m → h/j/k/l` | Move window left/down/up/right |
| `m → 1/2/3` | Move node to 💬/🌐/💻 (focus follows) |
| `m → !/@ /#` | Move node to 💬/🌐/💻 (no focus follow) |

## Theme

[Catppuccin Mocha](https://github.com/catppuccin/catppuccin) is used consistently across Ghostty, Neovim, and Zed.
