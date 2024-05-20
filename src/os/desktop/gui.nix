{ config, pkgs, ... }: {
  # KDE
  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma5.enable = true;
    # Remove xterm from default xserver install
    excludePackages = with pkgs; [
      xterm
    ];
    xkb.layout = "us";
  };
  # Remove broken browser integration (it doesn't work on Chrome)
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    plasma-browser-integration
  ];
}
