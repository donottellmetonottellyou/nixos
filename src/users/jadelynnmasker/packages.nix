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
    slack
    zoom-us
    # Games & Learning
    digital
    prismlauncher
  ];
}
