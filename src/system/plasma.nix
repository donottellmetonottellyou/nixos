{ lib, pkgs, ... }:
{
  services = {
    desktopManager.plasma6 = {
      enable = true;
    };
  };

  programs = {
    dconf.enable = true; # fixes gtk themes in wayland

    # Sets tty1 to be dedicated KDE display manager
    zsh.loginShellInit = ''
      if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
        echo Starting plasma...
        sleep 1
        exec startplasma-wayland
      fi
    '';
  };

  environment.etc."issue-tty1".text = ''
    KDE Plasma Console (tty1)
    This terminal automatically starts Plasma on login

    \n \r \d \t

    Please log in

  '';

  systemd.services."getty@tty1" = {
    overrideStrategy = "asDropin";
    serviceConfig = {
      ExecStart = lib.mkForce [
        ""
        "-${pkgs.util-linux}/sbin/agetty --issue-file /etc/issue-tty1 %I $TERM"
      ];
    };
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
