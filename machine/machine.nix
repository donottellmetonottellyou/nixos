{ config, pkgs, ... }: {
  imports = [
    ./hardware.nix
    ./host.nix
    ./network.nix
    ./power.nix
  ];
}
