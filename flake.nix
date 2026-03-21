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
            environment.systemPackages =
                [
                    pkgs.bat
                    pkgs.btop
                    pkgs.colima
                    pkgs.coreutils
                    pkgs.claude-code
                    pkgs.docker
                    pkgs.docker-compose
                    pkgs.findutils
                    pkgs.gawk
                    pkgs.gh
                    pkgs.git
                    pkgs.gnused
                    pkgs.gnupg
                    pkgs.jq
                    pkgs.mise
                    neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default
		    pkgs.nil
                    pkgs.obsidian
                    pkgs.opencode
                    pkgs.postgresql_18
                    pkgs.ripgrep
                    pkgs.slack
                    pkgs.starship
                    pkgs.stow
                    pkgs.tealdeer
		    pkgs.tree-sitter
                    pkgs.yazi
                    pkgs.zed-editor
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
                    "arc"
                    "karabiner-elements"
                    "beekeeper-studio"
                    "ghostty"
		    "firefox@developer-edition"
                    "yaak"
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
