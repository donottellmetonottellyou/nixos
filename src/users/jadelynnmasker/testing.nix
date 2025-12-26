{ pkgs, ... }:
{
  home.packages = with pkgs.donottellmetonottellyou; [
    (legendsviewer-next.override {
      patches = [
        ./patches/legendsviewer-always-open-browser.patch
        ./patches/legendsviewer-better-unix-directory-handling.patch
        ./patches/legendsviewer-favorites.patch
        ./patches/legendsviewer-fix404.patch
      ];
    })
  ];
}
