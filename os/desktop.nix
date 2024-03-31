{ config, pkgs, ... }: {
  # KDE
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    # Remove xterm
    excludePackages = with pkgs; [
      xterm
    ];
  };
}
