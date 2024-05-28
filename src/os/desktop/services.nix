{ lib, ... }: {
  services = {
    openssh.enable = lib.mkOverride 999 false;

    # Mumble chat server
    murmur = {
      enable = true;
      openFirewall = true;
    };
  };
}
