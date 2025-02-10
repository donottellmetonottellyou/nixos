{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    fira-code
    git-filter-repo
    micro
    neovim
    nix-output-monitor
  ];

  programs = {
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
        safe.directory = [
          "/etc/nixos"
          "/home/jadelynnmasker/Code/NixOS"
        ];
      };
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-tty;
    };

    # Per-directory cached dev environments
    direnv = {
      enable = true;
      silent = true;
    };
  };
}
