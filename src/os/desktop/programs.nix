{ config, pkgs, ... }: {
  programs = {
    steam = {
      enable = true;
      # localNetworkGameTransfers.openFirewall = true; # future config
      extraCompatPackages = with pkgs; [
        proton-ge-bin
        steamtinkerlaunch
      ];
    };
  };
}
