{ config, pkgs, ... }: {
  # KDE
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    # Remove xterm from default xserver install
    excludePackages = with pkgs; [
      xterm
    ];
    xkb.layout = "us";
  };
  environment = {
    # Remove broken browser integration (it doesn't work on Chrome)
    plasma5.excludePackages = with pkgs.libsForQt5; [
      plasma-browser-integration
    ];
    # Make gtk apps use plasma file picker
    variables = {
      GTK_USE_PORTAL = "1";
    };
  };
}
