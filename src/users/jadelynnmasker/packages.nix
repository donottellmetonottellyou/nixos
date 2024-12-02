{ pkgs, ...}: {
  home.packages = with pkgs; [
    # Language support
    markdown-oxide # markdown
    marksman       # markdown
    nil            # nix
    nixpkgs-fmt    # nix
    taplo          # toml
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
    ckan
    digital
    prismlauncher
  ];
}
