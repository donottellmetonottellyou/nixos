{ config, pkgs, ... }: {
  # Enable networking
  networking.networkmanager.enable = true;

  # Enables wireless support via wpa_supplicant.
  # networking.wireless.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # Needed for expo go
  networking.firewall.allowedTCPPorts = [ 8081 ];
  networking.firewall.allowedUDPPorts = [ 8081 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
