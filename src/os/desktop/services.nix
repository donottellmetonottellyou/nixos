{ lib, ... }: {
  services = {
    # Mumble chat server
    murmur = {
      enable = true;
      openFirewall = true;
    };
  };
}
