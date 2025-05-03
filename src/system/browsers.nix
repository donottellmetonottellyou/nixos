{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    chromium
  ];

  programs = {
    # Preferred browser
    firefox.enable = true;

    # Backup, all tracking / signin disabled chromium browser.
    chromium = {
      enable = true;
      extraOpts = {
        # Disable Google Signin
        BrowserSignin = 0;
        SyncDisabled = true;
        # Disable customization
        DefaultBrowserSettingEnabled = false;
        BrowserLabsEnabled = false;
        BlockExternalExtensions = true;
        ExtensionInstallBlocklist = [ "*" ];
        # Disable autofill
        PasswordManagerEnabled = false;
        PasswordManagerPasskeysEnabled = false;
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
      };
    };
  };
}
