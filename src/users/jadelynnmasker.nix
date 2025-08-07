{ pkgs, config, ... }:
{
  users.users.jadelynnmasker = {
    isNormalUser = true;
    description = "Jade Lynn Masker";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  imports = [
    ./jadelynnmasker/pipewire.nix
    ./jadelynnmasker/syncthing.nix
  ];

  home-manager.users.jadelynnmasker =
    { ... }:
    {
      home.stateVersion = config.system.stateVersion;

      xdg = {
        enable = true;
        autostart = {
          enable = true;
          readOnly = true;
        };
      };

      imports = [
        ./jadelynnmasker/desktop.nix

        # Programs
        ./jadelynnmasker/email.nix
        ./jadelynnmasker/git.nix
        ./jadelynnmasker/helix.nix
        ./jadelynnmasker/terminal.nix

        # Fork testing
        ./jadelynnmasker/testing.nix
      ];
    };
}
