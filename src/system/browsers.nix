{ ... }:
{
  programs = {
    # Preferred browser
    firefox.enable = true;

    # Backup, all tracking / signin disabled chromium browser.
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
