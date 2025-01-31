{ pkgs, ...}: {
  home.packages = with pkgs; [
    # Passwords
    keepassxc
    # Chat & Video
    discord
    revolt-desktop
    slack
    zoom-us
    # Wikis
    kiwix
    # Games & Learning
    digital
    prismlauncher
  ];
}
