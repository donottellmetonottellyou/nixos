{ pkgs, ... }: {
  # List packages installed in system profile for desktop. To search, run
  # `nixos-listpkgs`
  environment.systemPackages = with pkgs; [
    # backup browser
    chromium
    # VPN
    protonvpn-gui
    # Programming font
    fira-code
    # Office suite
    krita
    libreoffice
  ];
}
