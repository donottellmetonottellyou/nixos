{ pkgs, ... }: {
  services.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6 = {
    enable = true;
  };

  environment = {
    # Remove broken browser integration (it doesn't work on Chrome)
    plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
    ];
    # Make gtk apps use plasma file picker
    variables = {
      GTK_USE_PORTAL = "1";
    };
  };
}
