{ pkgs, ... }: {
  programs = {
    chromium = {
      enable = true;
      extraOpts = {
        "BrowserSignin" = 0;
        "SyncDisabled" = true;
        "PasswordManagerEnabled" = false;
        "BrowserGuestModeEnforced" = true;
        "DefaultBrowserSettingEnabled" = false;
        "BrowserLabsEnabled" = false;
      };
    };
    firefox.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };
}
