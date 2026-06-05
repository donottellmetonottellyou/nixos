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
    # Remote desktop
    rustdesk
    # Games & Learning
    bottles
    ckan
    crawlTiles
    digital
    endless-sky
    itch
    (prismlauncher.override {
      jdks = [
        jdk8
        jdk21
        jdk25
      ];
    })
    uqm
    wineWow64Packages.waylandFull
  ];

  xdg.autostart.entries = with pkgs; [
    "${keepassxc}/share/applications/org.keepassxc.KeePassXC.desktop"
    # "${birdtray}/share/applications/com.ulduzsoft.Birdtray.desktop"
  ];
}
