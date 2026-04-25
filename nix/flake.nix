{
    description = "nix-darwin system flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        nix-darwin.url = "github:nix-darwin/nix-darwin/master";
        nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
        nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    };

    outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
    let
        configuration = { pkgs, ... }: {
            # List packages installed in system profile. To search by name, run:
            # $ nix-env -qaP | grep wget
            environment.systemPackages = with pkgs; [
                bat
                colima
                coreutils
                claude-code
                docker
                docker-compose
                fd
                findutils
                fnm
                fzf
                gawk
                gh
                git
                gnused
                gnupg
                jq
                neovim
                nil
                nixd
                obsidian
                opencode
                ripgrep
                slack
                starship
                stow
                tealdeer
                tmux
                tree-sitter
            ];

            # Homebrew for packages not available in nixpkgs.
            homebrew = {
                enable = true;
                onActivation = {
                    autoUpdate = true;
                upgrade = true;
                    cleanup = "zap";
                };
                taps = [
                    "nikitabobko/tap"
                    "docker/tap"
                ];
                casks = [
                    "beekeeper-studio"
                    "docker/tap/sbx"
                    "figma"
                    "firefox@developer-edition"
                    "ghostty"
                    "karabiner-elements"
                    "lm-studio"
                    "nikitabobko/tap/aerospace"
                    "yaak"
                    "zed"
                    "zen"
                ];
            };

            # Necessary for using flakes on this system.
            nix.settings.experimental-features = "nix-command flakes";

            # Enable alternative shell support in nix-darwin.
            programs.fish.enable = true;

            # Add fish to /etc/shells
            environment.shells = [ pkgs.fish ];

            # Set Git commit hash for darwin-version.
            system.configurationRevision = self.rev or self.dirtyRev or null;

            # Used for backwards compatibility, please read the changelog before changing.
            # $ darwin-rebuild changelog
            system.stateVersion = 6;

            system.primaryUser = "nicolas";

            users.users.nicolas.shell = pkgs.fish;

            system.defaults = {
                dock.autohide = true;
                finder.FXPreferredViewStyle = "clmv";
                loginwindow.GuestEnabled = false;
                NSGlobalDomain.AppleInterfaceStyle = "Dark";
            };

            fonts.packages = [
                pkgs.nerd-fonts.jetbrains-mono
                pkgs.nerd-fonts.monaspace
            ];

            system.activationScripts.postActivation.text = ''
                echo "Run this from the repo root to symlink dotfiles:"
                echo "  stow ."
            '';

            nixpkgs = {
                # The platform the configuration will be used on.
                hostPlatform = "aarch64-darwin";

                # Allow unfree packages.
                config.allowUnfree = true;
            };
        };
    in
        {
            # Build darwin flake using:
            # $ darwin-rebuild build --flake .#Nicks-MacBook-Pro
            darwinConfigurations."Nicks-MacBook-Pro" = nix-darwin.lib.darwinSystem {
                modules = [
                    configuration
                    nix-homebrew.darwinModules.nix-homebrew
                    {
                        nix-homebrew = {
                            enable = true;
                            enableRosetta = true;
                            user = "nicolas";
                            autoMigrate = true;
                        };
                    }
                ];
            };
        };
}
