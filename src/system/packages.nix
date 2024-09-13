{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # General programming tools
    fira-code
    micro
    neovim
    nil
    nixpkgs-fmt
    # Office suite
    chromium
    krita
    libreoffice
    protonvpn-gui
  ];
}
