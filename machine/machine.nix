{ config, pkgs, ... }: {
  imports = [
    ./host.nix
    ./network.nix
    ./peripherals.nix
    ./power.nix
    ./sound.nix
  ];
}
