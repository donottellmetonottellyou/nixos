{ ... }: {
  programs = {
    zsh = {
      enable = true;
      enableBashCompletion = true;
      autosuggestions.enable = true;
      ohMyZsh = {
        enable = true;
        theme = "steeef";
      };
      interactiveShellInit = ''
        fastfetch --load-config neofetch
      '';
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
    };

    # Per-directory cached dev environments
    direnv = {
      enable = true;
      silent = true;
    };
  };
}
