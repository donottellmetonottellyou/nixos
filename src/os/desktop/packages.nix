{ config, pkgs, ... }: {
  # List packages installed in system profile for desktop. To search, run
  # `nixos-listpkgs`
  environment.systemPackages = with pkgs; [
    # Steam addon
    steamtinkerlaunch
    # Office suite
    fira-code
    firefox
    krita
    libreoffice
    libsForQt5.kcalc
    libsForQt5.kcharselect
  ];
}
