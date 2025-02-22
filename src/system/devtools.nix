{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      fira-code # Code font
      micro # System editor, with default keybinds
      neovim # System vim editor, replaced by helix for myself
      nix-output-monitor # Useful metrics while installing nixos
    ];

    variables = {
      EDITOR = "micro";
    };
  };

  programs = {
    # Not default shell, but available to all users
    zsh = {
      enable = true;
      enableBashCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        theme = "robbyrussell";
      };
    };

    git = {
      enable = true;
      config = {
        core.fsmonitor = true;
        init.defaultBranch = "main";
        # Make it so commit-config, amend-config, and push-config work
        safe.directory = [
          "/etc/nixos"
          "/home/jadelynnmasker/Code/NixOS"
        ];
      };
    };

    # GPG signing
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      # Simple, terminal-based prompt
      pinentryPackage = pkgs.pinentry-tty;
    };

    # Per-directory cached dev environments
    direnv = {
      enable = true;
      silent = true;
    };
  };
}
