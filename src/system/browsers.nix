{ ... }: {
  programs = {
    firefox.enable = true;

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
  };
}
