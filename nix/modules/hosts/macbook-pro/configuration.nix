{ self, inputs, ... }: {
  flake.darwinModules.macBookProConfiguration = { pkgs, lib, ... }: {
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep <package>
    environment.systemPackages = with pkgs; [
      # Language servers
      bash-language-server
      basedpyright
      docker-language-server
      docker-compose-language-service
      fish-lsp
      graphql-language-service-cli
      nixd
      prisma-language-server
      tailwindcss-language-server
      typescript-language-server
      vscode-css-languageserver
      vscode-json-languageserver
      yaml-language-server

      # Utils
      bat
      coreutils
      fd
      findutils
      fzf
      gawk
      gnused
      gnupg
      jq
      ripgrep
      stow
      tealdeer
      tree
      zoxide

      # Editors
      helix
      neovim

      # Dev tools
      colima
      docker
      docker-compose
      fnm
      gh
      git
      mise

      # TUI apps
      glow

      # Clankers
      claude-code
      github-copilot-cli
      ollama
      opencode

      # Misc
      starship
      tree-sitter
    ];

    nix-homebrew = {
      enable = true;
      user = "nicolas";
      enableRosetta = false;
      mutableTaps = true;
    };

    homebrew = {
      enable = true;

      casks = [
        "beekeeper-studio"
        "firefox@developer-edition"
        "ghostty"
        "netnewswire"
        "obsidian"
        "slack"
        "yaak"
        "zed"
      ];

      onActivation = {
        autoUpdate = true;
        upgrade = true;
        cleanup = "zap";
      };
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

    system.keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    fonts.packages = [
      pkgs.nerd-fonts.fira-code
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.nerd-fonts.monaspace
      pkgs.monaspace
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
}
