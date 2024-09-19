{ pkgs, ... }: {
  programs = {
    zsh = {
      enable = true;
      enableBashCompletion = true;
      autosuggestions.enable = true;
      ohMyZsh = {
        enable = true;
        theme = "robbyrussell";
      };
      interactiveShellInit = ''
        if [[ -z "$ZELLIJ" ]]; then
          zellij attach -c
          exit
        fi
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
      pinentryPackage = pkgs.pinentry-gtk2;
    };

    # Per-directory cached dev environments
    direnv = {
      enable = true;
      silent = true;
    };

    firefox.enable = true;

    chromium = {
      enable = true;
      extraOpts = {
        "BrowserSignin" = 0;
        "SyncDisabled" = true;
        "PasswordManagerEnabled" = false;
        "BrowserGuestModeEnforced" = true;
        "DefaultBrowserSettingEnabled" = false;
        "BrowserLabsEnabled" = false;
      };
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      extraCompatPackages = [
        pkgs.proton-ge-bin
      ];
    };
  };
}
