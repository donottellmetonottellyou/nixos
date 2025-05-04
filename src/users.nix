{ ... }:
{
  imports = [
    <home-manager/nixos>

    ./users/jadelynnmasker.nix
    ./users/kids.nix
  ];

  home-manager = {
    # Install in /etc/profiles instead of $HOME/.nix-profile
    useUserPackages = true;
    # I don't have to reconfigure all the same stuff twice
    useGlobalPkgs = true;
    # Please make this show more of the error, NixOS devs!
    backupFileExtension = "old";
  };
}
