{ ... }:
{
  services.pipewire.extraConfig.pipewire-pulse.custom = {
    "pulse.cmd" = [
      {
        cmd = "load-module";
        args = "module-virtual-sink sink_name=network";
      }
      {
        cmd = "load-module";
        args = "module-simple-protocol-tcp rate=48000 listen=0.0.0.0 port=12345 record=true source=input.network.monitor";
      }
    ];
  };
  networking.firewall.allowedTCPPorts = [ 12345 ];
}
