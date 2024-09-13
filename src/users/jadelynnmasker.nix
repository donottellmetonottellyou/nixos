{ config, ... }: {
  users.users.jadelynnmasker = {
    isNormalUser = true;
    description = "Jade Lynn Masker";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.users.jadelynnmasker = { pkgs, ... }: {
    home.stateVersion = config.system.stateVersion;

    imports = [
      ./jadelynnmasker/packages.nix

      # Programs
      ./jadelynnmasker/git.nix
      ./jadelynnmasker/helix.nix
      ./jadelynnmasker/vscode.nix
    ];
  };
}
