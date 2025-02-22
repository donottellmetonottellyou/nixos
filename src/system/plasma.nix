{ pkgs, ... }: {
  services = {
    displayManager.sddm = {
      enable = true;
      autoNumlock = false;
      wayland.enable = true;
    };
    desktopManager.plasma6 = {
      enable = true;
    };

    fwupd.enable = true; # <- needed for kinfocenter
  };

  programs = {
    dconf.enable = true; # fixes gtk themes in wayland
  };

  # Fixes issue with xdg-open, which opens default applications
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr.enable = true;
  };

  environment = {
    systemPackages = (with pkgs; [
      digikam # photo management
      exiftool # digikam
      kitty # replaces konsole
      krita # painter
      libreoffice-qt6-fresh # documents
      vlc # video

      # \/ needed for kinfocenter \/
      aha
      clinfo
      glxinfo
      pciutils
      vulkan-tools
      wayland-utils
      # /\ needed for kinfocenter /\
    ]) ++ (with pkgs.kdePackages;[
      # \/ extra kde utils \/
      filelight
      isoimagewriter
      kcalc
      kcharselect
      kclock
      partitionmanager
      plasma-browser-integration
      plasma-disks
      # /\ extra kde utils /\
    ]);

    plasma6.excludePackages = with pkgs.kdePackages; [
      kate
      konsole
      okular
    ];
    # Make gtk apps use plasma file picker
    variables = {
      GTK_USE_PORTAL = "1";
    };
  };
}
