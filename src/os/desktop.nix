{ config, pkgs, ... }: {
  imports = [
    ./desktop/packages.nix
    ./desktop/plasma.nix
    ./desktop/programs.nix
    ./desktop/services.nix
  ];
}
