{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # General programming tools
    fastfetch
    fira-code
    micro
    neovim
    nixd
    nixpkgs-fmt
    # Office suite
    chromium
    krita
    libreoffice
    protonvpn-gui
    # Custom shell scripts
    (writeShellScriptBin "nixos-listpkgs" ''
      nix-store -q --requisites /run/current-system/sw |
        sed 's|/nix/store/[a-z0-9]*-||' |
        sort |
        uniq |
        column -c "$(tput cols)"
    '')
  ];
}
