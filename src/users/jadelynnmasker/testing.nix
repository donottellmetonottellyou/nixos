{ pkgs, ... }:
{
  home.packages = with pkgs.donottellmetonottellyou; [
    legendsviewer-next
  ];
}
