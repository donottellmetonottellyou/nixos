{ pkgs, ... }: {
  # List packages installed in system profile for desktop. To search, run
  # `nixos-listpkgs`
  environment.systemPackages = with pkgs; [
    # Steam addon
    steamtinkerlaunch
    # Office suite
    fira-code
    kdePackages.kcalc
    kdePackages.kcharselect
    krita
    libreoffice
  ];
}
