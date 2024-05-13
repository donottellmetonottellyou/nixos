{ config, pkgs, ... }: {
  imports = [
    ./desktop/gui.nix
    ./desktop/packages.nix
    ./desktop/programs.nix
    ./desktop/services.nix
  ];
}
