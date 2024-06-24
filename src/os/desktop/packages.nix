{ pkgs, ... }: {
  # List packages installed in system profile for desktop. To search, run
  # `nixos-listpkgs`
  environment.systemPackages = with pkgs; [
    # VPN
    protonvpn-gui
    # Programming font
    fira-code
    # Office suite
    brave
    kdePackages.filelight
    kdePackages.isoimagewriter
    kdePackages.kcalc
    kdePackages.kcharselect
    kdePackages.partitionmanager
    kdePackages.plasma-disks
    krita
    libreoffice
  ];
}
