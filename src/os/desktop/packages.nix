{ pkgs, ... }: {
  # List packages installed in system profile for desktop. To search, run
  # `nixos-listpkgs`
  environment.systemPackages = with pkgs; [
    # VPN
    protonvpn-gui
    # Programming font
    fira-code
    # Office suite
    krita
    libreoffice
  ];
}
