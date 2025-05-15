{ pkgs, ... }:
{
  home.packages = with pkgs.donottellmetonottellyou; [
    (legendsviewer-next.overrideAttrs {
      patches = [
        ./legendsviewer-always-open-browser.patch
        ./legendsviewer-better-unix-directory-handling.patch
        ./legendsviewer-fix404.patch
      ];
    })
  ];
}
