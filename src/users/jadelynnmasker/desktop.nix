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
    ckan
    crawlTiles
    digital
    endless-sky
    (prismlauncher.override {
      jdks = [
        jdk21
        jdk25
      ];
    })
    uqm
  ];

  xdg.autostart.entries = with pkgs; [
    # "${keepassxc}/share/applications/org.keepassxc.KeePassXC.desktop"
    # "${birdtray}/share/applications/com.ulduzsoft.Birdtray.desktop"
  ];
}
