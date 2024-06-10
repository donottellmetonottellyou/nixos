{ pkgs, ... }: {
  # List packages installed in system profile for desktop. To search, run
  # `nixos-listpkgs`
  environment.systemPackages = with pkgs; [
    # VPN
    protonvpn-gui
    # Office suite
    fira-code
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
