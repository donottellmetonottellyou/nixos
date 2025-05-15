{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      micro # System editor, with default keybinds
      neovim # System vim editor, replaced by helix for myself
      nix-output-monitor # Useful metrics while installing nixos
      python312Packages.pygments # Syntax highlighting for colorize
    ];

    variables = {
      EDITOR = "hx";
    };
  };

  users.defaultUserShell = pkgs.zsh;

  programs = {
    # Better prompt
    starship = {
      enable = true;
      presets = [
        "plain-text-symbols"
      ];
      settings = {
        directory.truncate_to_repo = false;
      };
    };

    zsh = {
      enable = true;
      enableBashCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        theme = "";
        plugins = [
          "colored-man-pages"
          "colorize"
          "git"
          "history-substring-search"
          "rust"
          "sudo"
        ];
      };
    };

    git = {
      enable = true;
      config = {
        core = {
          fsmonitor = true;
          untrackedcache = true;
        };
        init.defaultBranch = "main";
        # Make it so commit-config, amend-config, and push-config work
        safe.directory = [
          "/etc/nixos"
        ];
      };
    };

    # GPG signing
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # Per-directory cached dev environments
    direnv = {
      enable = true;
      silent = true;
    };
  };
}
