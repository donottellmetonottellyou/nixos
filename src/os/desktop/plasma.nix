{ pkgs, ... }: {
  services.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6 = {
    enable = true;
  };

  # Fixes issue with xdg-open, which opens default applications
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr.enable = true;
  };

  environment = {
    systemPackages = with pkgs.kdePackages; [
      filelight
      isoimagewriter
      kcalc
      kcharselect
      kclock
      partitionmanager
      plasma-disks
    ];

    plasma6.excludePackages = with pkgs.kdePackages; [
      kate
      okular
    ];
    # Make gtk apps use plasma file picker
    variables = {
      GTK_USE_PORTAL = "1";
    };
  };
}
