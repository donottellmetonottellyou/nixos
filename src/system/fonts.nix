{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      antialias = true;
      defaultFonts = rec {
        emoji = monospace;
        monospace = [ "FiraCode Nerd Font" ];
        sansSerif = monospace;
        serif = monospace;
      };
      hinting = {
        enable = false;
        autohint = false;
        style = "none";
      };
      subpixel = {
        lcdfilter = "none";
        rgba = "none";
      };
    };

    packages = with pkgs; [
      # Prefered main (default font)
      nerd-fonts.fira-code
      # Compatibility with Word for libreoffice
      corefonts
      # Google free fonts
      google-fonts
      # Emoji extension font
      font-awesome
    ];
  };
}
