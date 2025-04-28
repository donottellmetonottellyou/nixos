{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Passwords
    keepassxc
    # Chat & Video
    discord
    slack
    zoom-us
    # Wikis
    kiwix
    # Games & Learning
    digital
    prismlauncher
  ];
}
