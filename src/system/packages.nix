{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # General programming tools
    fira-code
    git-filter-repo
    micro
    neovim
    # Office suite
    chromium
    digikam
    exiftool # digikam
    krita
    libreoffice
    protonvpn-gui
  ];
}
