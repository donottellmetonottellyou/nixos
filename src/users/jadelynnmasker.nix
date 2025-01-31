{ pkgs, config, ... }: {
  users.users.jadelynnmasker = {
    isNormalUser = true;
    description = "Jade Lynn Masker";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  imports = [
    ./jadelynnmasker/syncthing.nix
  ];

  home-manager.users.jadelynnmasker = { pkgs, ... }: {
    home.stateVersion = config.system.stateVersion;

    imports = [
      ./jadelynnmasker/desktop.nix

      # Programs
      ./jadelynnmasker/email.nix
      ./jadelynnmasker/git.nix
      ./jadelynnmasker/helix.nix
      ./jadelynnmasker/terminal.nix
    ];
  };
}
