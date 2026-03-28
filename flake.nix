{
    description = "nix-darwin system flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        nix-darwin.url = "github:nix-darwin/nix-darwin/master";
        nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
        nix-homebrew.url = "github:zhaofengli/nix-homebrew";
        neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    };

    outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, neovim-nightly-overlay }:
    let
        configuration = { pkgs, ... }: {
            # List packages installed in system profile. To search by name, run:
            # $ nix-env -qaP | grep wget
            environment.systemPackages = with pkgs; [
                bat
                btop
                colima
                coreutils
                claude-code
                docker
                docker-compose
                findutils
                gawk
                gh
                git
                gnused
                gnupg
                jq
                mise
                neovim-nightly-overlay.packages.${stdenv.hostPlatform.system}.default
                nil
				nixd
                obsidian
                opencode
                postgresql_18
                ripgrep
                slack
                starship
                stow
                tealdeer
                tree-sitter
                vscode
                yazi
                zed-editor
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
                ];
                casks = [
                    "nikitabobko/tap/aerospace"
                    "zen"
                    "karabiner-elements"
                    "beekeeper-studio"
                    "ghostty"
                    "firefox@developer-edition"
                    "yaak"
                    "figma"
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

            fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

            system.activationScripts.postActivation.text = ''
                echo "Run this from the repo root to symlink dotfiles:"
                echo "  stow dotfiles"
            '';

            nixpkgs = {
                # The platform the configuration will be used on.
                hostPlatform = "aarch64-darwin";

                # Allow unfree packages.
                config.allowUnfree = true;

                # Fix direnv CGO build failure on darwin.
                overlays = [
                    (final: prev: {
                        direnv = prev.direnv.overrideAttrs (old: {
                            postPatch = (old.postPatch or "") + ''
                                substituteInPlace GNUmakefile --replace-fail " -linkmode=external" ""
                            '';
                        });
                    })
                ];
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
