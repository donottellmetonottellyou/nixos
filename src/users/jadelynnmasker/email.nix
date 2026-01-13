{ pkgs, ... }:
{
  home.packages = with pkgs; [
    birdtray
  ];

  programs.thunderbird = {
    enable = true;
    profiles.default = {
      isDefault = true;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
      userChrome = ''
        #mail-notification-top {
          display: none;
        }
      '';
      withExternalGnupg = true;
    };
  };
}
