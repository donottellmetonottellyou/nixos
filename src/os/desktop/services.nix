{ config, pkgs, ... }: {
  services = {
    openssh.enable = pkgs.lib.mkOverride 999 false;

    # Mumble chat server
    murmur = {
      enable = true;
      openFirewall = true;
    };
  };
}
