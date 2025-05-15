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
      pulseaudioSupport = true;
      xdgDesktopPortalSupport = true;
    })
    # Wikis
    kiwix
    # Games & Learning
    digital
    prismlauncher
  ];
}
