{ config, pkgs, ... }: {
  imports = [
    ./desktop.nix
    ./maintenance.nix
    ./packages.nix
    ./region.nix
  ];
}
