{ pkgs, ... }:
{
  virtualisation.virtualbox = {
    host = {
      enable = true;
      addNetworkInterface = false;
    };
  };
}
