{ lib, pkgs, ... }:
{
  services = {
    desktopManager.plasma6 = {
      enable = true;
      enableQt5Integration = false;
    };
    displayManager.plasma-login-manager = {
      enable = true;
    };
  };

  programs = {
    dconf.enable = true; # fixes gtk themes in wayland
  };

  # Fixes issue with xdg-open, which opens default applications
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };

  environment = {
    systemPackages =
      (with pkgs; [
        digikam # photo management
        exiftool # digikam
        kitty # replaces konsole
        krita # painter
        libreoffice-qt6-fresh # documents
        vlc # video

        # \/ needed for kinfocenter \/
        aha
        clinfo
        mesa-demos
        pciutils
        vulkan-tools
        wayland-utils
        # /\ needed for kinfocenter /\
      ])
      ++ (with pkgs.kdePackages; [
        karousel # scrollable tiler
        # \/ extra kde utils \/
        filelight
        isoimagewriter
        kcalc
        kcharselect
        kclock
        kdenlive
        kjournald
        partitionmanager
        plasma-browser-integration
        plasma-disks
        skanpage # scanner utility
        # /\ extra kde utils /\
      ]);

    plasma6.excludePackages = with pkgs.kdePackages; [
      kate # replaced by helix
      konsole # replaced by kitty
      okular # use web browser
    ];
    # Make gtk apps use plasma file picker
    variables = {
      GTK_USE_PORTAL = "1";
    };
  };
}
