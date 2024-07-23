{ pkgs, ... }: {
  services = {
    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
    };
    desktopManager.plasma6 = {
      enable = true;
    };

    fwupd.enable = true; # <- needed for kinfocenter
  };

  programs = {
    dconf.enable = true; # fixes gtk themes in wayland
    kde-pim.enable = true; # Fixes account auth
  };

  # Fixes issue with xdg-open, which opens default applications
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr.enable = true;
  };

  environment = {
    systemPackages = (with pkgs; [
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
      plasma-disks
      # /\ extra kde utils /\
      # \/ kmail & depends \/
      kmail
      kmailtransport
      kmail-account-wizard
      ktexttemplate
      # /\ kmail & depends /\
      # \/ cloud integration \/
      kaccounts-integration
      kaccounts-providers
      kio-gdrive
      # /\ cloud integration /\
    ]);

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
