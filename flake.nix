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
                    pkgs.neovim
                    pkgs.nerd-fonts.jetbrains-mono
                    pkgs.nil
                    pkgs.obsidian
                    pkgs.opencode
                    pkgs.postgresql_18
                    pkgs.ripgrep
                    pkgs.slack
                    pkgs.starship
                    pkgs.stow
                    pkgs.tealdeer
                    pkgs.tmux
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
                    "copilot-cli"
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
