{ config, pkgs, ... }: {
  imports = [
    ./machine/host.nix
    ./machine/network.nix
    ./machine/peripherals.nix
    ./machine/power.nix
  ];
}
