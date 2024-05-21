{ config, pkgs, ... }: {
  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      # localNetworkGameTransfers.openFirewall = true; # future config
      extraCompatPackages = with pkgs; [
        proton-ge-bin
        steamtinkerlaunch
      ];
    };
  };
}
