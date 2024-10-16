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
    kde-pim = {
      kmail = true;
      kontact = true;
      merkuro = true;
    };
  };

  # Fixes issue with xdg-open, which opens default applications
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr.enable = true;
  };

  environment = {
    systemPackages = (with pkgs; [
      (runCommandLocal "breeze-cursors-fix" { } ''
        dir=$out/share/icons
        mkdir -p $dir
        ln -s ${kdePackages.breeze}/share/icons/breeze_cursors $dir/default
      '')
      kitty # replaces konsole
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
      # \/ cloud integration \/
      kaccounts-integration
      kaccounts-providers
      kio-gdrive
      # /\ cloud integration /\
      qtimageformats # webp compat
    ]);

    plasma6.excludePackages = with pkgs.kdePackages; [
      kate
      konsole # replaced by kitty
      okular
    ];
    # Make gtk apps use plasma file picker
    variables = {
      GTK_USE_PORTAL = "1";
    };
  };
}
