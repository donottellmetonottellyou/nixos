{ pkgs, ... }:
{
  services = {
    # Default Plasma login
    displayManager.sddm = {
      enable = true;
      autoNumlock = false;
      wayland = {
        enable = true;
        compositor = "kwin";
      };
    };
    desktopManager.plasma6 = {
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

  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      antialias = false;
      defaultFonts = rec {
        emoji = monospace;
        monospace = [ "FiraCode Nerd Font" ];
        sansSerif = monospace;
        serif = monospace;
      };
      hinting.enable = false;
      subpixel.lcdfilter = "none";
    };
    packages = with pkgs; [
      nerd-fonts.fira-code
    ];
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
        glxinfo
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
