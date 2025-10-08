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
    # Wikis
    kiwix
    # Games & Learning
    crawlTiles
    digital
    (prismlauncher.override {
      jdks = [
        unstable.jdk25
      ];
    })
  ];

  xdg.autostart.entries = with pkgs; [
    "${keepassxc}/share/applications/org.keepassxc.KeePassXC.desktop"
  ];
}
