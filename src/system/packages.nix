{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # General programming tools
    fira-code
    micro
    neovim
    zellij
    # Office suite
    chromium
    krita
    libreoffice
    protonvpn-gui
  ];
}
