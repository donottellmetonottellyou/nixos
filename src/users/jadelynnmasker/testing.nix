{ pkgs, ... }:
{
  home.packages = with pkgs.donottellmetonottellyou; [
    (legendsviewer-next.overrideAttrs {
      patches = [
        ./legendsviewer-always-open-browser.patch
        ./legendsviewer-fix404.patch
      ];
    })
  ];
}
