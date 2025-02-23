{
  description = "Awesum Darwin System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs = inputs@{ 
    self, 
    nix-darwin, 
    nixpkgs, 
    nix-homebrew, 
    homebrew-core, 
    homebrew-cask, 
    homebrew-bundle, 
    ... 
  }:
  let
    configuration = { pkgs, ... }: {
      # maybe include later:
      # Manual installs:
      # - karabiner-elements
      # - kanata (in dotfiles)
      # - Zen Browser
      # - Brave browser
      environment.systemPackages = [ 
        pkgs.ansible
        pkgs.awscli
        pkgs.bat
        pkgs.borgbackup
        pkgs.brave
        pkgs.btop
        pkgs.bun
        pkgs.cyberduck
        pkgs.code-cursor
        pkgs.coreutils
        pkgs.docker
        pkgs.docker-compose
        pkgs.docker-ls
        pkgs.eza
        pkgs.fzf
        pkgs.gh
        pkgs.git
        pkgs.github-copilot-cli
        pkgs.gitkraken
        pkgs.gnumake
        pkgs.jankyborders
        pkgs.jq
        pkgs.kubectl
        pkgs.lazygit
        pkgs.neovim
        pkgs.obsidian
        pkgs.postgresql
        pkgs.python3Full
        pkgs.qemu
        pkgs.qmk
        pkgs.raycast
        pkgs.ripgrep
        pkgs.signal-desktop
        pkgs.sketchybar
        pkgs.speedtest-cli
        pkgs.starship
        pkgs.stow
        pkgs.telegram-desktop
        pkgs.terraform
        pkgs.thefuck
        pkgs.tree
        pkgs.tree-sitter
        pkgs.vim
        pkgs.vivid
        pkgs.vscode
        pkgs.warp-terminal
        pkgs.wezterm
        pkgs.xz
        pkgs.yq
        pkgs.zoxide
        pkgs.zoom-us
        pkgs.zsh
        pkgs.zellij
      ];
      
      fonts.packages = [ 
          pkgs.nerd-fonts.fira-code
          pkgs.nerd-fonts.hack
          pkgs.nerd-fonts.jetbrains-mono
          pkgs.nerd-fonts.mononoki
          pkgs.nerd-fonts.ubuntu-mono
          pkgs.nerd-fonts.roboto-mono
      ];

     homebrew = {
        enable = true;
        casks = [
            "1password-cli"
            "vorta"
            "ghostty"
            "shortcat"
            "aerospace"
        ];
        brews = [
          {
            name = "sketchybar";
            start_service = true;
          }
          {
            name = "borders";
            start_service = true;
          }
          "kanata"
          "mas"
          "node"
          "imagemagick"
        ];
        taps = [
        ];
        masApps = {
          "Things" = 904280696;
          "Drafts" = 1435957248;
          "Cyberduck" = 409222199;
          "Tiny Ipsum" = 1445179392;
          "Timery" = 1425368544;
          "Todoist" = 585829637;
          "The Unarchiver" = 425424353;
          "Numbers" = 409203825;
          "Pages" = 409201541;
          "WebSSH" = 497714887;
          "Fantastical" = 975937182;
          "Sequel Ace" = 1518036000;
          "Dark Noise" = 1465439395;
          "Parcel" = 639968404;
          "Spark Desktop" = 6445813049;
        };
        onActivation.cleanup = "zap";
      };

      security.pam.enableSudoTouchIdAuth = true;
      nixpkgs.config.allowUnfree = true;
      nix.settings.trusted-users = [ "root" "jasonbiggs" ];
      nix.settings.experimental-features = "nix-command flakes";
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 6;
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    darwinConfigurations."knight" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration 
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "jasonbiggs";
            autoMigrate = true;
          };
        }
      ];
    };
  };
}
