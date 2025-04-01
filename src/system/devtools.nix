{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      micro # System editor, with default keybinds
      neovim # System vim editor, replaced by helix for myself
      nix-output-monitor # Useful metrics while installing nixos
    ];

    variables = {
      EDITOR = "micro";
    };
  };

  users.defaultUserShell = pkgs.zsh;

  programs = {
    # Better prompt
    starship = {
      enable = true;
      presets = [
        "nerd-font-symbols"
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
      interactiveShellInit = ''
        # autocompletion using arrow keys (based on history)
        bindkey '\eOA' history-search-backward
        bindkey '\eOB' history-search-forward
      '';
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
