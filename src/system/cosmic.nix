{ pkgs, ... }:
{
  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
  };

  programs = {
    dconf = {
      enable = true;
      profiles.user.databases = [
        {
          settings = {
            "org/gnome/desktop/interface" = {
              color-scheme = "prefer-dark";
              gtk-theme = "Adwaita-dark";
            };
          };
        }
      ];
    };
  };

  # Fixes issue with xdg-open, which opens default applications
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };

  environment.systemPackages = with pkgs; [
    libreoffice-fresh # documents

    # \/ Extra Cosmic Utils
    cosmic-ext-calculator
    cosmic-ext-tweaks
    # /\ Extra Cosmic Utils
  ];

}
