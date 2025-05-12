{ pkgs, ... }:
{
  home.packages = with pkgs.donottellmetonottellyou; [
    (legendsviewer-next.overrideAttrs {
      patches = [ ./legendsviewer-fix404.patch ];
    })
  ];
}
