{ config, pkgs, ... }: {
  imports = [
    ./os/common.nix
    ./os/desktop.nix
  ];
}
