{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Passwords
    keepassxc
    # Chat & Video
    discord
    slack
    webex
    (zoom-us.overrideAttrs {
      xdgDesktopPortalSupport = true;
    })
    # Games & Learning
    crawlTiles
    digital
    (prismlauncher.override {
      jdks = [
        jdk21
        jdk25
      ];
    })
  ];

  xdg.autostart.entries = with pkgs; [
    "${keepassxc}/share/applications/org.keepassxc.KeePassXC.desktop"
  ];
}
